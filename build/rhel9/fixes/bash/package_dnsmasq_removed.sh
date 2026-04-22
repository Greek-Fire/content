# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove dnsmasq
# from the system, and may remove any packages
# that depend on dnsmasq. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "dnsmasq" ; then
dnf remove -y --noautoremove "dnsmasq"
fi