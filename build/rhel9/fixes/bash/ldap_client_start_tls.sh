# platform = Red Hat Virtualization 4,multi_platform_rhel,multi_platform_ol,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if rpm --quiet -q nss-pam-ldapd; then

# Use LDAP for authentication
# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^USELDAPAUTH")

# shellcheck disable=SC2059
printf -v formatted_output "%s=%s" "$stripped_key" "yes"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^USELDAPAUTH\\>" "/etc/sysconfig/authconfig"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^USELDAPAUTH\\>.*/$escaped_formatted_output/gi" "/etc/sysconfig/authconfig"
else
    if [[ -s "/etc/sysconfig/authconfig" ]] && [[ -n "$(tail -c 1 -- "/etc/sysconfig/authconfig" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/sysconfig/authconfig"
    fi
    printf '%s\n' "$formatted_output" >> "/etc/sysconfig/authconfig"
fi

# Configure client to use TLS for all authentications
# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^ssl")

# shellcheck disable=SC2059
printf -v formatted_output "%s %s" "$stripped_key" "start_tls"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^ssl\\>" "/etc/nslcd.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^ssl\\>.*/$escaped_formatted_output/gi" "/etc/nslcd.conf"
else
    if [[ -s "/etc/nslcd.conf" ]] && [[ -n "$(tail -c 1 -- "/etc/nslcd.conf" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/nslcd.conf"
    fi
    printf '%s\n' "$formatted_output" >> "/etc/nslcd.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi