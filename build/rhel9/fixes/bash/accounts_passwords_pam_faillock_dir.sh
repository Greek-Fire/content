# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q pam; }; then

var_accounts_passwords_pam_faillock_dir='(bash-populate var_accounts_passwords_pam_faillock_dir)'


if [ -f /usr/bin/authselect ]; then
    if ! authselect check; then
echo "
authselect integrity check failed. Remediation aborted!
This remediation could not be applied because an authselect profile was not selected or the selected profile is not intact.
It is not recommended to manually edit the PAM files when authselect tool is available.
In cases where the default authselect profile does not cover a specific demand, a custom authselect profile is recommended."
exit 1
fi
authselect enable-feature with-faillock

authselect apply-changes -b
else
    
AUTH_FILES=("/etc/pam.d/system-auth" "/etc/pam.d/password-auth")
for pam_file in "${AUTH_FILES[@]}"
do
    if ! grep -qE '^\s*auth\s+required\s+pam_faillock\.so\s+(preauth silent|authfail).*$' "$pam_file" ; then
        sed -i --follow-symlinks '/^auth.*sufficient.*pam_unix\.so.*/i auth        required      pam_faillock.so preauth silent' "$pam_file"
        sed -i --follow-symlinks '/^auth.*required.*pam_deny\.so.*/i auth        required      pam_faillock.so authfail' "$pam_file"
        sed -i --follow-symlinks '/^account.*required.*pam_unix\.so.*/i account     required      pam_faillock.so' "$pam_file"
    fi
    sed -Ei 's/(auth.*)(\[default=die\])(.*pam_faillock\.so)/\1required     \3/g' "$pam_file"
done

fi

AUTH_FILES=("/etc/pam.d/system-auth" "/etc/pam.d/password-auth")
SKIP_FAILLOCK_CHECK=false

FAILLOCK_CONF="/etc/security/faillock.conf"
if [ -f $FAILLOCK_CONF ] || [ "$SKIP_FAILLOCK_CHECK" = "true" ]; then
    regex="^\s*dir\s*="
    line="dir = $var_accounts_passwords_pam_faillock_dir"
    if ! grep -q $regex $FAILLOCK_CONF; then
        echo $line >> $FAILLOCK_CONF
    else
        sed -i --follow-symlinks 's|^\s*\(dir\s*=\s*\)\(\S\+\)|\1'"$var_accounts_passwords_pam_faillock_dir"'|g' $FAILLOCK_CONF
    fi
    
    for pam_file in "${AUTH_FILES[@]}"
    do
        if [ -e "$pam_file" ] ; then
            PAM_FILE_PATH="$pam_file"
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
                PAM_FILE_NAME=$(basename "$pam_file")
                PAM_FILE_PATH="/etc/authselect/$CURRENT_PROFILE/$PAM_FILE_NAME"

                authselect apply-changes -b
            fi
            
        if grep -qP "^\s*auth\s.*\bpam_faillock.so\s.*\bdir\b" "$PAM_FILE_PATH"; then
            sed -i -E --follow-symlinks "s/(.*auth.*pam_faillock.so.*)\bdir\b=?[[:alnum:]]*(.*)/\1\2/g" "$PAM_FILE_PATH"
        fi
            if [ -f /usr/bin/authselect ]; then
                
                authselect apply-changes -b
            fi
        else
            echo "$pam_file was not found" >&2
        fi
    done
    
else
    for pam_file in "${AUTH_FILES[@]}"
    do
        if ! grep -qE '^\s*auth.*pam_faillock\.so\s+(preauth|authfail).*dir' "$pam_file"; then
            sed -i --follow-symlinks '/^auth.*required.*pam_faillock\.so.*preauth.*/ s/$/ dir='"$var_accounts_passwords_pam_faillock_dir"'/' "$pam_file"
            sed -i --follow-symlinks '/^auth.*required.*pam_faillock\.so.*authfail.*/ s/$/ dir='"$var_accounts_passwords_pam_faillock_dir"'/' "$pam_file"
        else
            sed -i --follow-symlinks 's/\(^auth.*required.*pam_faillock\.so.*preauth.*\)\('"dir"'=\)\S\+\b\(.*\)/\1\2'"$var_accounts_passwords_pam_faillock_dir"'\3/' "$pam_file"
            sed -i --follow-symlinks 's/\(^auth.*required.*pam_faillock\.so.*authfail.*\)\('"dir"'=\)\S\+\b\(.*\)/\1\2'"$var_accounts_passwords_pam_faillock_dir"'\3/' "$pam_file"
        fi
    done
fi

if ! rpm -q --quiet "python3-libselinux" ; then
    dnf install -y "python3-libselinux"
fi
if ! rpm -q --quiet "python3-policycoreutils" ; then
    dnf install -y "python3-policycoreutils"
fi
if ! rpm -q --quiet "policycoreutils-python-utils" ; then
    dnf install -y "policycoreutils-python-utils"
fi

mkdir -p "$var_accounts_passwords_pam_faillock_dir"
# Workaround for https://github.com/OpenSCAP/openscap/issues/2242: Use full
# path to semanage and restorecon commands to avoid the issue with the command
# not being found.
/usr/sbin/semanage fcontext -a -t faillog_t "$var_accounts_passwords_pam_faillock_dir(/.*)?"
/usr/sbin/restorecon -R -v "$var_accounts_passwords_pam_faillock_dir"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi