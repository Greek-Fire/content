# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q chrony; }; then

config_files=(/etc/ntp.conf)
config_files+=("/etc/chrony.conf")

chrony_d_path=/etc/chrony.d/
if [[ -d $chrony_d_path ]]; then
    while IFS= read -r filename; do
        config_files+=("$filename")
    done < <(find "$chrony_d_path" -type f -name '*.conf')
fi

for config_file in "${config_files[@]}"; do
    [[ -e $config_file ]] || continue
    # if the line doesn't start with 'server/pool/peer ', just print it
    # if the line does contain ' nts' already, skip it
    # else append ' nts' to it
    sed "/^\(server\|pool\|peer\) /! b; / nts/ b; s/$/ nts/" -i "$config_file"
done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi