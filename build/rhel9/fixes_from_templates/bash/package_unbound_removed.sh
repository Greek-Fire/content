# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove unbound
# from the system, and may remove any packages
# that depend on unbound. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "unbound" ; then
dnf remove -y --noautoremove "unbound"
fi
