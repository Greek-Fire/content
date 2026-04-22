# platform = multi_platform_rhel,multi_platform_ol,multi_platform_fedora,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if rpm --quiet -q dnf; then

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^gpgcheck")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "1"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^gpgcheck\\>" "/etc/dnf/dnf.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^gpgcheck\\>.*/$escaped_formatted_output/gi" "/etc/dnf/dnf.conf"
else
    if [[ -s "/etc/dnf/dnf.conf" ]] && [[ -n "$(tail -c 1 -- "/etc/dnf/dnf.conf" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/dnf/dnf.conf"
    fi
    cce="CCE-83457-2"
    printf '# Per %s: Set %s in %s\n' "${cce}" "${formatted_output}" "/etc/dnf/dnf.conf" >> "/etc/dnf/dnf.conf"
    printf '%s\n' "$formatted_output" >> "/etc/dnf/dnf.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi