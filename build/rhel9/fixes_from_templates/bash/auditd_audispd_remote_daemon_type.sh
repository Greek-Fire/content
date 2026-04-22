# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low


if [ -e "/etc/audit/plugins.d/au-remote.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*type\s*=\s*/Id" "/etc/audit/plugins.d/au-remote.conf"
else
    touch "/etc/audit/plugins.d/au-remote.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/audit/plugins.d/au-remote.conf"

cp "/etc/audit/plugins.d/au-remote.conf" "/etc/audit/plugins.d/au-remote.conf.bak"
# Insert at the end of the file
printf '%s\n' "type = always" >> "/etc/audit/plugins.d/au-remote.conf"
# Clean up after ourselves.
rm "/etc/audit/plugins.d/au-remote.conf.bak"