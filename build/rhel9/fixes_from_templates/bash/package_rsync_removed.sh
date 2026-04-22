# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove rsync-daemon
# from the system, and may remove any packages
# that depend on rsync-daemon. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "rsync-daemon" ; then
dnf remove -y --noautoremove "rsync-daemon"
fi
