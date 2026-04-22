# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q systemd; }; then

var_multiple_time_servers='(bash-populate var_multiple_time_servers)'

IFS=',' read -r -a time_servers_array <<< "$var_multiple_time_servers"
preferred_ntp_servers_array=("${time_servers_array[@]:0:2}")
preferred_ntp_servers=$( echo "${preferred_ntp_servers_array[@]}" )
fallback_ntp_servers_array=("${time_servers_array[@]:2}")
fallback_ntp_servers=$( echo "${fallback_ntp_servers_array[@]}" )

IFS=" " mapfile -t current_cfg_arr < <(ls -1 /etc/systemd/timesyncd.conf.d/* 2>/dev/null)

current_cfg_arr+=( "/etc/systemd/timesyncd.conf" )
# Comment existing NTP FallbackNTP settings
for current_cfg in "${current_cfg_arr[@]}"
do
    sed -i 's/^NTP/#&/g' "$current_cfg"
    sed -i 's/^FallbackNTP/#&/g' "$current_cfg"
done

# Set primary fallback NTP servers in drop-in configuration
# Create /etc/systemd/timesyncd.conf.d if it doesn't exist
if [ ! -d "/etc/systemd/timesyncd.conf.d" ]
then 
    mkdir /etc/systemd/timesyncd.conf.d
fi


# Try find '[Time]' and 'NTP' in '/etc/systemd/timesyncd.conf.d/oscap-remedy.conf', if it exists, set
# to '$preferred_ntp_servers', if it isn't here, add it, if '[Time]' doesn't exist, add it there
if grep -qzosP '[[:space:]]*\[Time]([^\n\[]*\n+)+?[[:space:]]*NTP' '/etc/systemd/timesyncd.conf.d/oscap-remedy.conf'; then
    
    sed -i "s/NTP[^(\n)]*/NTP=$preferred_ntp_servers/" '/etc/systemd/timesyncd.conf.d/oscap-remedy.conf'
elif grep -qs '[[:space:]]*\[Time]' '/etc/systemd/timesyncd.conf.d/oscap-remedy.conf'; then
    sed -i "/[[:space:]]*\[Time]/a NTP=$preferred_ntp_servers" '/etc/systemd/timesyncd.conf.d/oscap-remedy.conf'
else
    if test -d "/etc/systemd/timesyncd.conf.d"; then
        printf '%s\n' '[Time]' "NTP=$preferred_ntp_servers" >> '/etc/systemd/timesyncd.conf.d/oscap-remedy.conf'
    else
        echo "Config file directory '/etc/systemd/timesyncd.conf.d' doesnt exist, not remediating, assuming non-applicability." >&2
    fi
fi

# Try find '[Time]' and 'FallbackNTP' in '/etc/systemd/timesyncd.conf.d/oscap-remedy.conf', if it exists, set
# to '$fallback_ntp_servers', if it isn't here, add it, if '[Time]' doesn't exist, add it there
if grep -qzosP '[[:space:]]*\[Time]([^\n\[]*\n+)+?[[:space:]]*FallbackNTP' '/etc/systemd/timesyncd.conf.d/oscap-remedy.conf'; then
    
    sed -i "s/FallbackNTP[^(\n)]*/FallbackNTP=$fallback_ntp_servers/" '/etc/systemd/timesyncd.conf.d/oscap-remedy.conf'
elif grep -qs '[[:space:]]*\[Time]' '/etc/systemd/timesyncd.conf.d/oscap-remedy.conf'; then
    sed -i "/[[:space:]]*\[Time]/a FallbackNTP=$fallback_ntp_servers" '/etc/systemd/timesyncd.conf.d/oscap-remedy.conf'
else
    if test -d "/etc/systemd/timesyncd.conf.d"; then
        printf '%s\n' '[Time]' "FallbackNTP=$fallback_ntp_servers" >> '/etc/systemd/timesyncd.conf.d/oscap-remedy.conf'
    else
        echo "Config file directory '/etc/systemd/timesyncd.conf.d' doesnt exist, not remediating, assuming non-applicability." >&2
    fi
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi