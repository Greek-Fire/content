# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q audit && rpm --quiet -q kernel-core; then

AUDISP_REMOTE_CONFIG="/etc/audit/audisp-remote.conf"

option="^enable_krb5"
value="yes"


# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "$option")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "$option\\>" "$AUDISP_REMOTE_CONFIG"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/$option\\>.*/$escaped_formatted_output/gi" "$AUDISP_REMOTE_CONFIG"
else
    if [[ -s "$AUDISP_REMOTE_CONFIG" ]] && [[ -n "$(tail -c 1 -- "$AUDISP_REMOTE_CONFIG" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "$AUDISP_REMOTE_CONFIG"
    fi
    cce="CCE-86621-0"
    printf '# Per %s: Set %s in %s\n' "${cce}" "${formatted_output}" "$AUDISP_REMOTE_CONFIG" >> "$AUDISP_REMOTE_CONFIG"
    printf '%s\n' "$formatted_output" >> "$AUDISP_REMOTE_CONFIG"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi