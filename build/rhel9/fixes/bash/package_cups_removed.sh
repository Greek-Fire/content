# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove cups
# from the system, and may remove any packages
# that depend on cups. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "cups" ; then
dnf remove -y --noautoremove "cups"
fi