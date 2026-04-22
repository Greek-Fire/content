# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove ntp
# from the system, and may remove any packages
# that depend on ntp. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "ntp" ; then
dnf remove -y --noautoremove "ntp"
fi
