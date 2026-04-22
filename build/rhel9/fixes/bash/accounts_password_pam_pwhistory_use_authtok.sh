# platform = multi_platform_rhel
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q pam; }; then

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
pam_profile="$(head -1 /etc/authselect/authselect.conf)"
if grep -Pq -- '^custom\/' <<< "$pam_profile"; then
    pam_profile_path="/etc/authselect/$pam_profile"
else
    pam_profile_path="/usr/share/authselect/default/$pam_profile"
fi

for authselect_file in "$pam_profile_path"/password-auth "$pam_profile_path"/system-auth; do
    if ! grep -Pq '^\h*password\h+([^#\n\r]+)\h+pam_pwhistory\.so\h+([^#\n\r]+\h+)?use_authtok\b' "$authselect_file"; then
        sed -ri 's/(^\s*password\s+(requisite|required|sufficient)\s+pam_pwhistory\.so\s+.*)$/& use_authtok/g' "$authselect_file"
    fi
done

authselect apply-changes

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi