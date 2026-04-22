# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove python3-abrt-addon
# from the system, and may remove any packages
# that depend on python3-abrt-addon. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "python3-abrt-addon" ; then
dnf remove -y --noautoremove "python3-abrt-addon"
fi
