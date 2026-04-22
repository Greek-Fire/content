# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

var_password_hashing_min_rounds_login_defs='(bash-populate var_password_hashing_min_rounds_login_defs)'


config_file=/etc/login.defs
current_min_rounds=$(grep -Po '^\s*SHA_CRYPT_MIN_ROUNDS\s+\K\d+' "$config_file")
current_max_rounds=$(grep -Po '^\s*SHA_CRYPT_MAX_ROUNDS\s+\K\d+' "$config_file")

if [[ -z "$current_min_rounds" || "$current_min_rounds" -le "$var_password_hashing_min_rounds_login_defs" ]]; then
    if [ -e "/etc/login.defs" ] ; then
        
        LC_ALL=C sed -i "/^\s*SHA_CRYPT_MIN_ROUNDS\s*/Id" "/etc/login.defs"
    else
        printf '%s\n' "Path '/etc/login.defs' wasn't found on this system. Refusing to continue." >&2
        return 1
    fi
    # make sure file has newline at the end
    sed -i -e '$a\' "/etc/login.defs"

    cp "/etc/login.defs" "/etc/login.defs.bak"
    # Insert at the end of the file
    printf '%s\n' "SHA_CRYPT_MIN_ROUNDS $var_password_hashing_min_rounds_login_defs" >> "/etc/login.defs"
    # Clean up after ourselves.
    rm "/etc/login.defs.bak"
fi

if [[ -n "$current_max_rounds" && "$current_max_rounds" -le "$var_password_hashing_min_rounds_login_defs" ]]; then
    if [ -e "/etc/login.defs" ] ; then
        
        LC_ALL=C sed -i "/^\s*SHA_CRYPT_MAX_ROUNDS\s*/Id" "/etc/login.defs"
    else
        printf '%s\n' "Path '/etc/login.defs' wasn't found on this system. Refusing to continue." >&2
        return 1
    fi
    # make sure file has newline at the end
    sed -i -e '$a\' "/etc/login.defs"

    cp "/etc/login.defs" "/etc/login.defs.bak"
    # Insert at the end of the file
    printf '%s\n' "SHA_CRYPT_MAX_ROUNDS $var_password_hashing_min_rounds_login_defs" >> "/etc/login.defs"
    # Clean up after ourselves.
    rm "/etc/login.defs.bak"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi