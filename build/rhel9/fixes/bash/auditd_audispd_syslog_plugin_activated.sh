# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q audit && rpm --quiet -q kernel-core; then

var_syslog_active="yes"

AUDISP_SYSLOGCONFIG=/etc/audit/plugins.d/syslog.conf

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^active")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$var_syslog_active"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^active\\>" "$AUDISP_SYSLOGCONFIG"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^active\\>.*/$escaped_formatted_output/gi" "$AUDISP_SYSLOGCONFIG"
else
    if [[ -s "$AUDISP_SYSLOGCONFIG" ]] && [[ -n "$(tail -c 1 -- "$AUDISP_SYSLOGCONFIG" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "$AUDISP_SYSLOGCONFIG"
    fi
    cce="CCE-83695-7"
    printf '# Per %s: Set %s in %s\n' "${cce}" "${formatted_output}" "$AUDISP_SYSLOGCONFIG" >> "$AUDISP_SYSLOGCONFIG"
    printf '%s\n' "$formatted_output" >> "$AUDISP_SYSLOGCONFIG"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi