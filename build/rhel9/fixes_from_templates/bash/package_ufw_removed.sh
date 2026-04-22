# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove ufw
# from the system, and may remove any packages
# that depend on ufw. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "ufw" ; then
dnf remove -y --noautoremove "ufw"
fi
