# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if ( ! ( grep -sqE "^.*\.s390x$" /proc/sys/kernel/osrelease || grep -sqE "^s390x$" /proc/sys/kernel/arch; ) && rpm --quiet -q kernel-core ); then

echo "allow with-interface match-all { 09:00:* }" >> /etc/usbguard/rules.conf

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi