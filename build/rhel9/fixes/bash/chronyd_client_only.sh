# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q chrony; }; then

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^port")

# shellcheck disable=SC2059
printf -v formatted_output "%s %s" "$stripped_key" "0"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^port\\>" "/etc/chrony.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^port\\>.*/$escaped_formatted_output/gi" "/etc/chrony.conf"
else
    if [[ -s "/etc/chrony.conf" ]] && [[ -n "$(tail -c 1 -- "/etc/chrony.conf" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/chrony.conf"
    fi
    cce="CCE-87543-5"
    printf '# Per %s: Set %s in %s\n' "${cce}" "${formatted_output}" "/etc/chrony.conf" >> "/etc/chrony.conf"
    printf '%s\n' "$formatted_output" >> "/etc/chrony.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi