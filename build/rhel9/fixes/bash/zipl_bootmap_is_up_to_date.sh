# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if ( grep -sqE "^.*\.s390x$" /proc/sys/kernel/osrelease || grep -sqE "^s390x$" /proc/sys/kernel/arch; ) && { ( [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ] ); }; then

/usr/sbin/zipl

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi