# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

chmod u-wr,g-wrs,o-xwrt /usr/bin/sudo

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi