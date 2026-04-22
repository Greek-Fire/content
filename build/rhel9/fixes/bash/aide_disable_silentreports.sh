# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

if [ -e "" ] ; then
    
    LC_ALL=C sed -i "/^\s*SILENTREPORTS=/Id" ""
else
    touch ""
fi
# make sure file has newline at the end
sed -i -e '$a\' ""

cp "" ".bak"
# Insert at the end of the file
printf '%s\n' "SILENTREPORTS=no" >> ""
# Clean up after ourselves.
rm ".bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi