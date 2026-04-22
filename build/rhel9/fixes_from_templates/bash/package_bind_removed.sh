# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove bind and bind9.18
# from the system, and may remove any packages
# that depend on bind and bind9.18. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "bind" ; then
dnf remove -y --noautoremove "bind"
fi

if rpm -q --quiet "bind9.18" ; then
dnf remove -y --noautoremove "bind9.18"
fi
