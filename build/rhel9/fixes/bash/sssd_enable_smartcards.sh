# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = medium
# Remediation is applicable only in certain platforms
if rpm --quiet -q sssd-common; then

# sssd configuration files must be created with 600 permissions if they don't exist
# otherwise the sssd module fails to start
OLD_UMASK=$(umask)
umask u=rw,go=

found=false

# set value in all files if they contain section or key
for f in $(echo -n "/etc/sssd/sssd.conf /etc/sssd/conf.d/*.conf"); do
    if [ ! -e "$f" ]; then
        continue
    fi

    # find key in section and change value
    if grep -qzosP "(?m)^[[:space:]]*\[pam\]([^\n\[]*\n+)+?[[:space:]]*pam_cert_auth" "$f"; then
        if ! grep -qzosP "(?m)^[[:space:]]*pam_cert_auth[[:space:]]*=[[:space:]]*True" "$f"; then

            sed -i "/^[[:space:]]*pam_cert_auth/s/\([[:blank:]]*=[[:blank:]]*\).*/\1True/" "$f"

        fi

        found=true

    # find section and add key = value to it
    elif grep -qs "^[[:space:]]*\[pam\]" "$f"; then

            sed -i "/^[[:space:]]*\[pam\]/a pam_cert_auth=True" "$f"

            found=true
    fi
done

# if section not in any file, append section with key = value to FIRST file in files parameter
if ! $found ; then
    file=$(echo "/etc/sssd/sssd.conf /etc/sssd/conf.d/*.conf" | cut -f1 -d ' ')
    mkdir -p "$(dirname "$file")"

    echo -e "[pam]\npam_cert_auth=True" >> "$file"

fi

umask $OLD_UMASK


if [ -f /usr/bin/authselect ]; then
    if ! authselect check; then
    echo "
    authselect integrity check failed. Remediation aborted!
    This remediation could not be applied because an authselect profile was not selected or the selected profile is not intact.
    It is not recommended to manually edit the PAM files when authselect tool is available.
    In cases where the default authselect profile does not cover a specific demand, a custom authselect profile is recommended."
    exit 1
    fi
    authselect enable-feature with-smartcard

    authselect apply-changes -b
else
    

    if ! grep -qP "^\s*auth\s+sufficient\s+pam_sss.so\s*.*" "/etc/pam.d/smartcard-auth"; then
        # Line matching group + control + module was not found. Check group + module.
        if [ "$(grep -cP '^\s*auth\s+.*\s+pam_sss.so\s*' "/etc/pam.d/smartcard-auth")" -eq 1 ]; then
            # The control is updated only if one single line matches.
            sed -i -E --follow-symlinks "s/^(\s*auth\s+).*(\bpam_sss.so.*)/\1sufficient \2/" "/etc/pam.d/smartcard-auth"
        else
            echo "auth    sufficient    pam_sss.so" >> "/etc/pam.d/smartcard-auth"
        fi
    fi
    # Check the option
    if ! grep -qP "^\s*auth\s+sufficient\s+pam_sss.so\s*.*\sallow_missing_name\b" "/etc/pam.d/smartcard-auth"; then
        sed -i -E --follow-symlinks "/\s*auth\s+sufficient\s+pam_sss.so.*/ s/$/ allow_missing_name/" "/etc/pam.d/smartcard-auth"
    fi
    

    if ! grep -qP "^\s*auth\s+\[success=done authinfo_unavail=ignore ignore=ignore default=die\]\s+pam_sss.so\s*.*" "/etc/pam.d/system-auth"; then
        # Line matching group + control + module was not found. Check group + module.
        if [ "$(grep -cP '^\s*auth\s+.*\s+pam_sss.so\s*' "/etc/pam.d/system-auth")" -eq 1 ]; then
            # The control is updated only if one single line matches.
            sed -i -E --follow-symlinks "s/^(\s*auth\s+).*(\bpam_sss.so.*)/\1[success=done authinfo_unavail=ignore ignore=ignore default=die] \2/" "/etc/pam.d/system-auth"
        else
            echo "auth    [success=done authinfo_unavail=ignore ignore=ignore default=die]    pam_sss.so" >> "/etc/pam.d/system-auth"
        fi
    fi
    # Check the option
    if ! grep -qP "^\s*auth\s+\[success=done authinfo_unavail=ignore ignore=ignore default=die\]\s+pam_sss.so\s*.*\stry_cert_auth\b" "/etc/pam.d/system-auth"; then
        sed -i -E --follow-symlinks "/\s*auth\s+\[success=done authinfo_unavail=ignore ignore=ignore default=die\]\s+pam_sss.so.*/ s/$/ try_cert_auth/" "/etc/pam.d/system-auth"
    fi
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi