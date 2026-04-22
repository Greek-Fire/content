# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low


if [ -e "/etc/chrony.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*makestep /Id" "/etc/chrony.conf"
else
    touch "/etc/chrony.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/chrony.conf"

cp "/etc/chrony.conf" "/etc/chrony.conf.bak"
# Insert at the end of the file
printf '%s\n' "makestep 1 -1" >> "/etc/chrony.conf"
# Clean up after ourselves.
rm "/etc/chrony.conf.bak"