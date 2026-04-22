# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove avahi
# from the system, and may remove any packages
# that depend on avahi. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "avahi" ; then
dnf remove -y --noautoremove "avahi"
fi