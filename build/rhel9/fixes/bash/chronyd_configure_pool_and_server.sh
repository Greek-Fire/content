# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q chrony; }; then

var_multiple_time_servers='(bash-populate var_multiple_time_servers)'

var_multiple_time_pools='(bash-populate var_multiple_time_pools)'


config_file="/etc/chrony.conf"

sed -i -e '$a\' "$config_file"

# Check and configigure servers in /etc/chrony.conf
IFS="," read -a SERVERS <<< $var_multiple_time_servers
for srv in "${SERVERS[@]}"
do
   NTP_SRV=$(grep -w $srv $config_file)
   if [[ ! "$NTP_SRV" == "server "* ]]
   then
     time_server="server $srv"
     echo $time_server >> "$config_file"
   fi
done

# Check and configure pools in /etc/chrony.conf
IFS="," read -a POOLS <<< $var_multiple_time_pools
for srv in "${POOLS[@]}"
do
   NTP_POOL=$(grep -w $srv $config_file)
   if [[ ! "$NTP_POOL" == "pool "* ]]
   then
     time_server="pool $srv"
     echo $time_server >> "$config_file"
   fi
done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi