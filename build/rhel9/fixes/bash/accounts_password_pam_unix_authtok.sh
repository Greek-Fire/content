# platform = multi_platform_rhel
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q pam; }; then

if ! grep -qP "^\s*password\s+sufficient\s+pam_unix.so\s*.*" "/etc/pam.d/system-auth"; then
    # Line matching group + control + module was not found. Check group + module.
    if [ "$(grep -cP '^\s*password\s+.*\s+pam_unix.so\s*' "/etc/pam.d/system-auth")" -eq 1 ]; then
        # The control is updated only if one single line matches.
        sed -i -E --follow-symlinks "s/^(\s*password\s+).*(\bpam_unix.so.*)/\1sufficient \2/" "/etc/pam.d/system-auth"
    else
        echo "password    sufficient    pam_unix.so" >> "/etc/pam.d/system-auth"
    fi
fi
# Check the option
if ! grep -qP "^\s*password\s+sufficient\s+pam_unix.so\s*.*\suse_authtok\b" "/etc/pam.d/system-auth"; then
    sed -i -E --follow-symlinks "/\s*password\s+sufficient\s+pam_unix.so.*/ s/$/ use_authtok/" "/etc/pam.d/system-auth"
fi


if ! grep -qP "^\s*password\s+sufficient\s+pam_unix.so\s*.*" "/etc/pam.d/password-auth"; then
    # Line matching group + control + module was not found. Check group + module.
    if [ "$(grep -cP '^\s*password\s+.*\s+pam_unix.so\s*' "/etc/pam.d/password-auth")" -eq 1 ]; then
        # The control is updated only if one single line matches.
        sed -i -E --follow-symlinks "s/^(\s*password\s+).*(\bpam_unix.so.*)/\1sufficient \2/" "/etc/pam.d/password-auth"
    else
        echo "password    sufficient    pam_unix.so" >> "/etc/pam.d/password-auth"
    fi
fi
# Check the option
if ! grep -qP "^\s*password\s+sufficient\s+pam_unix.so\s*.*\suse_authtok\b" "/etc/pam.d/password-auth"; then
    sed -i -E --follow-symlinks "/\s*password\s+sufficient\s+pam_unix.so.*/ s/$/ use_authtok/" "/etc/pam.d/password-auth"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi