# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if ( ! ( grep -sqE "^.*\.s390x$" /proc/sys/kernel/osrelease || grep -sqE "^s390x$" /proc/sys/kernel/arch; ) && rpm --quiet -q kernel-core ) && { rpm --quiet -q usbguard; }; then

if [ -e "/etc/usbguard/usbguard-daemon.conf" ] ; then
    
    LC_ALL=C sed -i "/^[ \\t]*AuditBackend=/Id" "/etc/usbguard/usbguard-daemon.conf"
else
    touch "/etc/usbguard/usbguard-daemon.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/usbguard/usbguard-daemon.conf"

cp "/etc/usbguard/usbguard-daemon.conf" "/etc/usbguard/usbguard-daemon.conf.bak"
# Insert at the end of the file
printf '%s\n' "AuditBackend=LinuxAudit" >> "/etc/usbguard/usbguard-daemon.conf"
# Clean up after ourselves.
rm "/etc/usbguard/usbguard-daemon.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi