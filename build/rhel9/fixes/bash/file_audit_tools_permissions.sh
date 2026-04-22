# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

chmod u-s,g-ws,o-wt /sbin/auditctl

chmod u-s,g-ws,o-wt /sbin/aureport

chmod u-s,g-ws,o-wt /sbin/ausearch

chmod u-s,g-ws,o-wt /sbin/autrace

chmod u-s,g-ws,o-wt /sbin/auditd

chmod u-s,g-ws,o-wt /sbin/rsyslogd

chmod u-s,g-ws,o-wt /sbin/augenrules

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi