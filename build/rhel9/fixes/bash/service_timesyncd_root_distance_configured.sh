# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q systemd; }; then

config_file="/etc/systemd/timesyncd.d/oscap-remedy.conf"
IFS=" " mapfile -t current_cfg_arr < <(ls -1 /etc/systemd/timesyncd.d/* 2>/dev/null)

current_cfg_arr+=( "/etc/systemd/timesyncd.conf" )
# Comment existing NTP RootDistanceMax settings
if [ ${#current_cfg_arr[@]} -ne 0 ]; then
    for current_cfg in "${current_cfg_arr[@]}"
    do
        sed -i 's/^RootDistanceMax/#&/g' "$current_cfg"
    done
fi
# Set RootDistance in drop-in configuration
echo "RootDistanceMax=1" >> "$config_file"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi