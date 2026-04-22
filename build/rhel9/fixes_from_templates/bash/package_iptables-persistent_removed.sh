# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove iptables-persistent
# from the system, and may remove any packages
# that depend on iptables-persistent. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "iptables-persistent" ; then
dnf remove -y --noautoremove "iptables-persistent"
fi
