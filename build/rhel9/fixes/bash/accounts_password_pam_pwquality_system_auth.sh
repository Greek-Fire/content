# platform = Red Hat Virtualization 4,multi_platform_fedora,multi_platform_rhel,multi_platform_ol,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q libpwquality; }; then

if [ -e "/etc/pam.d/system-auth" ] ; then
    PAM_FILE_PATH="/etc/pam.d/system-auth"
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
        PAM_FILE_NAME=$(basename "/etc/pam.d/system-auth")
        PAM_FILE_PATH="/etc/authselect/$CURRENT_PROFILE/$PAM_FILE_NAME"

        authselect apply-changes -b
    fi
    
if ! grep -qP "^\s*password\s+requisite\s+pam_pwquality.so\s*.*" "$PAM_FILE_PATH"; then
    # Line matching group + control + module was not found. Check group + module.
    if [ "$(grep -cP '^\s*password\s+.*\s+pam_pwquality.so\s*' "$PAM_FILE_PATH")" -eq 1 ]; then
        # The control is updated only if one single line matches.
        sed -i -E --follow-symlinks "s/^(\s*password\s+).*(\bpam_pwquality.so.*)/\1requisite \2/" "$PAM_FILE_PATH"
    else
        LAST_MATCH_LINE=$(grep -nP "^account.*required.*pam_permit\.so" "$PAM_FILE_PATH" | tail -n 1 | cut -d: -f 1)
        if [ ! -z $LAST_MATCH_LINE ]; then
            sed -i --follow-symlinks $LAST_MATCH_LINE" a password     requisite    pam_pwquality.so" "$PAM_FILE_PATH"
        else
            echo "password    requisite    pam_pwquality.so" >> "$PAM_FILE_PATH"
        fi
    fi
fi
    if [ -f /usr/bin/authselect ]; then
        
        authselect apply-changes -b
    fi
else
    echo "/etc/pam.d/system-auth was not found" >&2
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi