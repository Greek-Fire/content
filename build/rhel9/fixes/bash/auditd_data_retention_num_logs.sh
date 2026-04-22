# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q audit && rpm --quiet -q kernel-core; then

var_auditd_num_logs='(bash-populate var_auditd_num_logs)'


AUDITCONFIG=/etc/audit/auditd.conf

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^num_logs")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$var_auditd_num_logs"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^num_logs\\>" "$AUDITCONFIG"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^num_logs\\>.*/$escaped_formatted_output/gi" "$AUDITCONFIG"
else
    if [[ -s "$AUDITCONFIG" ]] && [[ -n "$(tail -c 1 -- "$AUDITCONFIG" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "$AUDITCONFIG"
    fi
    cce="CCE-83688-2"
    printf '# Per %s: Set %s in %s\n' "${cce}" "${formatted_output}" "$AUDITCONFIG" >> "$AUDITCONFIG"
    printf '%s\n' "$formatted_output" >> "$AUDITCONFIG"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi