# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { ( ( rpm --quiet -q chrony || rpm --quiet -q ntp ) ); }; then

var_time_service_set_maxpoll='(bash-populate var_time_service_set_maxpoll)'




pof="/usr/sbin/pidof"


CONFIG_FILES="/etc/ntp.conf"
$pof ntpd || {
    CHRONY_D_PATH=/etc/chrony.d/
    if [ -d "${CHRONY_D_PATH}" ]; then
        mapfile -t CONFIG_FILES < <(find ${CHRONY_D_PATH} -type f -name '*.conf')
    else
        CONFIG_FILES=()
    fi
    CONFIG_FILES+=(/etc/chrony.conf)
}

# get list of ntp files

for config_file in "${CONFIG_FILES[@]}" ; do
    # Set maxpoll values to var_time_service_set_maxpoll
    sed -i "s/^\(\(server\|pool\|peer\).*maxpoll\) [0-9,-][0-9]*\(.*\)$/\1 $var_time_service_set_maxpoll \3/" "$config_file"
done

for config_file in "${CONFIG_FILES[@]}" ; do
    # Add maxpoll to server, pool or peer entries without maxpoll
    grep "^\(server\|pool\|peer\)" "$config_file" | grep -v maxpoll | while read -r line ; do
        sed -i "s/$line/& maxpoll $var_time_service_set_maxpoll/" "$config_file"
    done
done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi