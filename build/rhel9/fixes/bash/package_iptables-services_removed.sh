# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q iptables; then

# CAUTION: This remediation script will remove iptables-services
# from the system, and may remove any packages
# that depend on iptables-services. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "iptables-services" ; then
dnf remove -y --noautoremove "iptables-services"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi