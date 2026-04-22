# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q systemd; }; then

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^CtrlAltDelBurstAction=")

# shellcheck disable=SC2059
printf -v formatted_output "%s=%s" "$stripped_key" "none"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^CtrlAltDelBurstAction=\\>" "/etc/systemd/system.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^CtrlAltDelBurstAction=\\>.*/$escaped_formatted_output/gi" "/etc/systemd/system.conf"
else
    if [[ -s "/etc/systemd/system.conf" ]] && [[ -n "$(tail -c 1 -- "/etc/systemd/system.conf" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/systemd/system.conf"
    fi
    cce="CCE-90308-8"
    printf '# Per %s: Set %s in %s\n' "${cce}" "${formatted_output}" "/etc/systemd/system.conf" >> "/etc/systemd/system.conf"
    printf '%s\n' "$formatted_output" >> "/etc/systemd/system.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi