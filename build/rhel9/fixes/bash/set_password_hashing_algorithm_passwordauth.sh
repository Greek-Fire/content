# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_rhv,multi_platform_ol,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q pam; }; then

var_password_hashing_algorithm_pam='(bash-populate var_password_hashing_algorithm_pam)'


# Allow multiple algorithms, but choose the first one for remediation
var_password_hashing_algorithm_pam="$(echo $var_password_hashing_algorithm_pam | cut -d \| -f 1)"

PAM_FILE_PATH="/etc/pam.d/password-auth"

if [ -e "$PAM_FILE_PATH" ] ; then
    PAM_FILE_PATH="$PAM_FILE_PATH"
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
        PAM_FILE_NAME=$(basename "$PAM_FILE_PATH")
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
        if ! grep -qP "^\s*password\s+sufficient\s+pam_unix.so\s*.*\s$var_password_hashing_algorithm_pam\b" "$PAM_FILE_PATH"; then
            sed -i -E --follow-symlinks "/\s*password\s+sufficient\s+pam_unix.so.*/ s/$/ $var_password_hashing_algorithm_pam/" "$PAM_FILE_PATH"
        fi
    if [ -f /usr/bin/authselect ]; then
        
        authselect apply-changes -b
    fi
else
    echo "$PAM_FILE_PATH was not found" >&2
fi

# Ensure only the correct hashing algorithm option is used.
declare -a HASHING_ALGORITHMS_OPTIONS=("sha512" "yescrypt" "gost_yescrypt" "blowfish" "sha256" "md5" "bigcrypt")

for hash_option in "${HASHING_ALGORITHMS_OPTIONS[@]}"; do
  if [ "$hash_option" != "$var_password_hashing_algorithm_pam" ]; then
    if grep -qP "^\s*password\s+.*\s+pam_unix.so\s+.*\b$hash_option\b" "$PAM_FILE_PATH"; then
      if [ -e "$PAM_FILE_PATH" ] ; then
    PAM_FILE_PATH="$PAM_FILE_PATH"
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
        PAM_FILE_NAME=$(basename "$PAM_FILE_PATH")
        PAM_FILE_PATH="/etc/authselect/$CURRENT_PROFILE/$PAM_FILE_NAME"

        authselect apply-changes -b
    fi
    
if grep -qP "^\s*password\s+.*\s+pam_unix.so\s.*\b$hash_option\b" "$PAM_FILE_PATH"; then
    sed -i -E --follow-symlinks "s/(.*password.*.*.*pam_unix.so.*)\b$hash_option\b=?[[:alnum:]]*(.*)/\1\2/g" "$PAM_FILE_PATH"
fi
    if [ -f /usr/bin/authselect ]; then
        
        authselect apply-changes -b
    fi
else
    echo "$PAM_FILE_PATH was not found" >&2
fi
    fi
  fi
done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi