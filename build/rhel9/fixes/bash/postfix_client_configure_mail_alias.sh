# platform = multi_platform_rhel,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_debian
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

var_postfix_root_mail_alias='(bash-populate var_postfix_root_mail_alias)'


# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^root")

# shellcheck disable=SC2059
printf -v formatted_output "%s: %s" "$stripped_key" "$var_postfix_root_mail_alias"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^root\\>" "/etc/aliases"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^root\\>.*/$escaped_formatted_output/gi" "/etc/aliases"
else
    if [[ -s "/etc/aliases" ]] && [[ -n "$(tail -c 1 -- "/etc/aliases" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/aliases"
    fi
    cce="CCE-90826-9"
    printf '# Per %s: Set %s in %s\n' "${cce}" "${formatted_output}" "/etc/aliases" >> "/etc/aliases"
    printf '%s\n' "$formatted_output" >> "/etc/aliases"
fi

if [ -f /usr/bin/newaliases ]; then
    newaliases
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi