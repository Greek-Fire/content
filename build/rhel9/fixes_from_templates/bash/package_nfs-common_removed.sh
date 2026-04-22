# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove nfs-common
# from the system, and may remove any packages
# that depend on nfs-common. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "nfs-common" ; then
dnf remove -y --noautoremove "nfs-common"
fi
