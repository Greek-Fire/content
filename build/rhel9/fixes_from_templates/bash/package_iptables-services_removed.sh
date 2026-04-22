# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove iptables-services
# from the system, and may remove any packages
# that depend on iptables-services. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "iptables-services" ; then
dnf remove -y --noautoremove "iptables-services"
fi
