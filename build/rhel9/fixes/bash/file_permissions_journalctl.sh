# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

chmod u-s,g-xws,o-xwrt /usr/bin/journalctl

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi