# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove abrt-libs
# from the system, and may remove any packages
# that depend on abrt-libs. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "abrt-libs" ; then
dnf remove -y --noautoremove "abrt-libs"
fi