# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

chmod u-xws,g-xws,o-xwrt /etc/sudoers

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi