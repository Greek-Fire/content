# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_rhv,multi_platform_sle,multi_platform_debian,multi_platform_almalinux,multi_platform_ubuntu
# Remediation is applicable only in certain platforms
if ( ( rpm --quiet -q pam && rpm --quiet -q kernel-core ) ); then

var_password_pam_unix_rounds='(bash-populate var_password_pam_unix_rounds)'



if [ -e "/etc/pam.d/password-auth" ] ; then
    PAM_FILE_PATH="/etc/pam.d/password-auth"
    if [ -f /usr/bin/authselect ]; then
        
        if ! authselect check; then
        echo "
        authselect integrity check failed. Remediation aborted!
        This remediation could not be applied because an authselect profile was not selected or the selected profile is not intact.
        It is not recommended to manually edit the PAM files when authselect tool is available.
        In cases where the default authselect profile does not cover a specific demand, a custom authselect profile is recommended."
        exit 1
        fi

        CURRENT_PROFILE=$(authselect current -r | awk '{ print $1 }')
        # If not already in use, a custom profile is created preserving the enabled features.
        if [[ ! $CURRENT_PROFILE == custom/* ]]; then
            ENABLED_FEATURES=$(authselect current | tail -n+3 | awk '{ print $2 }')
            # The "local" profile does not contain essential security features required by multiple Benchmarks.
            # If currently used, it is replaced by "sssd", which is the best option in this case.
            if [[ $CURRENT_PROFILE == local ]]; then
                CURRENT_PROFILE="sssd"
            fi
            authselect create-profile hardening -b $CURRENT_PROFILE
            CURRENT_PROFILE="custom/hardening"
            
            authselect apply-changes -b --backup=before-hardening-custom-profile
            authselect select $CURRENT_PROFILE
            for feature in $ENABLED_FEATURES; do
                authselect enable-feature $feature;
            done
            
            authselect apply-changes -b --backup=after-hardening-custom-profile
        fi
        PAM_FILE_NAME=$(basename "/etc/pam.d/password-auth")
        PAM_FILE_PATH="/etc/authselect/$CURRENT_PROFILE/$PAM_FILE_NAME"

        authselect apply-changes -b
    fi
    

        if ! grep -qP "^\s*password\s+sufficient\s+pam_unix.so\s*.*" "$PAM_FILE_PATH"; then
            # Line matching group + control + module was not found. Check group + module.
            if [ "$(grep -cP '^\s*password\s+.*\s+pam_unix.so\s*' "$PAM_FILE_PATH")" -eq 1 ]; then
                # The control is updated only if one single line matches.
                sed -i -E --follow-symlinks "s/^(\s*password\s+).*(\bpam_unix.so.*)/\1sufficient \2/" "$PAM_FILE_PATH"
            else
                echo "password    sufficient    pam_unix.so" >> "$PAM_FILE_PATH"
            fi
        fi
        # Check the option
        if ! grep -qP "^\s*password\s+sufficient\s+pam_unix.so\s*.*\srounds\b" "$PAM_FILE_PATH"; then
            sed -i -E --follow-symlinks "/\s*password\s+sufficient\s+pam_unix.so.*/ s/$/ rounds=$var_password_pam_unix_rounds/" "$PAM_FILE_PATH"
        else
            sed -i -E --follow-symlinks "s/(\s*password\s+sufficient\s+pam_unix.so\s+.*)(rounds=)[[:alnum:]]*\s*(.*)/\1\2$var_password_pam_unix_rounds \3/" "$PAM_FILE_PATH"
        fi
    if [ -f /usr/bin/authselect ]; then
        
        authselect apply-changes -b
    fi
else
    echo "/etc/pam.d/password-auth was not found" >&2
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi