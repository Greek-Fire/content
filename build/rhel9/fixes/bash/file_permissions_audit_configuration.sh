# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q audit && rpm --quiet -q kernel-core; then

find -P /etc/audit/ -maxdepth 1 -perm /u+xs,g+xws,o+xwrt  -type f -regextype posix-extended -regex '^.*audit(\.rules|d\.conf)$' -exec chmod u-xs,g-xws,o-xwrt {} \;

find -P /etc/audit/rules.d/ -maxdepth 1 -perm /u+xs,g+xws,o+xwrt  -type f -regextype posix-extended -regex '^.*\.rules$' -exec chmod u-xs,g-xws,o-xwrt {} \;

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi