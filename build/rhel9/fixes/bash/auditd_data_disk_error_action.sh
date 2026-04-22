# platform = Red Hat Virtualization 4,multi_platform_ol,multi_platform_rhel,multi_platform_ubuntu,multi_platform_almalinux,multi_platform_debian,multi_platform_fedora
# Remediation is applicable only in certain platforms
if rpm --quiet -q audit && rpm --quiet -q kernel-core; then

var_auditd_disk_error_action='(bash-populate var_auditd_disk_error_action)'


#
# If disk_error_action present in /etc/audit/auditd.conf, change value
# to var_auditd_disk_error_action, else
# add "disk_error_action = $var_auditd_disk_error_action" to /etc/audit/auditd.conf
#
var_auditd_disk_error_action="$(echo $var_auditd_disk_error_action | cut -d \| -f 1)"

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^disk_error_action")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$var_auditd_disk_error_action"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^disk_error_action\\>" "/etc/audit/auditd.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^disk_error_action\\>.*/$escaped_formatted_output/gi" "/etc/audit/auditd.conf"
else
    if [[ -s "/etc/audit/auditd.conf" ]] && [[ -n "$(tail -c 1 -- "/etc/audit/auditd.conf" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/audit/auditd.conf"
    fi
    cce="CCE-83690-8"
    printf '# Per %s: Set %s in %s\n' "${cce}" "${formatted_output}" "/etc/audit/auditd.conf" >> "/etc/audit/auditd.conf"
    printf '%s\n' "$formatted_output" >> "/etc/audit/auditd.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi