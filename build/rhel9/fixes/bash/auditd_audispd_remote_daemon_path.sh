# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q audit && rpm --quiet -q kernel-core; then

if [ -e "/etc/audit/plugins.d/au-remote.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*path\s*=\s*/Id" "/etc/audit/plugins.d/au-remote.conf"
else
    touch "/etc/audit/plugins.d/au-remote.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/audit/plugins.d/au-remote.conf"

cp "/etc/audit/plugins.d/au-remote.conf" "/etc/audit/plugins.d/au-remote.conf.bak"
# Insert at the end of the file
printf '%s\n' "path = /sbin/audisp-remote" >> "/etc/audit/plugins.d/au-remote.conf"
# Clean up after ourselves.
rm "/etc/audit/plugins.d/au-remote.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi