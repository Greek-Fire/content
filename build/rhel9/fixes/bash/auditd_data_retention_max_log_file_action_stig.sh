# platform = Red Hat Virtualization 4,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_sle,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if rpm --quiet -q audit && rpm --quiet -q kernel-core; then

var_auditd_max_log_file_action='(bash-populate var_auditd_max_log_file_action)'


# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^max_log_file_action")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$var_auditd_max_log_file_action"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^max_log_file_action\\>" "/etc/audit/auditd.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^max_log_file_action\\>.*/$escaped_formatted_output/gi" "/etc/audit/auditd.conf"
else
    if [[ -s "/etc/audit/auditd.conf" ]] && [[ -n "$(tail -c 1 -- "/etc/audit/auditd.conf" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/audit/auditd.conf"
    fi
    cce="CCE-88396-7"
    printf '# Per %s: Set %s in %s\n' "${cce}" "${formatted_output}" "/etc/audit/auditd.conf" >> "/etc/audit/auditd.conf"
    printf '%s\n' "$formatted_output" >> "/etc/audit/auditd.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi