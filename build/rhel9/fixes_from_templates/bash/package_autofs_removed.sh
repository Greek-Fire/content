# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove autofs
# from the system, and may remove any packages
# that depend on autofs. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "autofs" ; then
dnf remove -y --noautoremove "autofs"
fi
