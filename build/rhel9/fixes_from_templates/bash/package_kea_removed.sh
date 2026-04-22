# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove kea
# from the system, and may remove any packages
# that depend on kea. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "kea" ; then
dnf remove -y --noautoremove "kea"
fi
