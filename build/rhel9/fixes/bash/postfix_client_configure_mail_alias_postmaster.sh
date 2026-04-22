# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

if [ -e "/etc/aliases" ] ; then
    
    LC_ALL=C sed -i "/^\s*postmaster\s*:\s*/Id" "/etc/aliases"
else
    touch "/etc/aliases"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/aliases"

cp "/etc/aliases" "/etc/aliases.bak"
# Insert at the end of the file
printf '%s\n' "postmaster: root" >> "/etc/aliases"
# Clean up after ourselves.
rm "/etc/aliases.bak"

if [ -f /usr/bin/newaliases ]; then
    newaliases
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi