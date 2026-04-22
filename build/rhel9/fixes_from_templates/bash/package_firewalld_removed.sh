# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove firewalld
# from the system, and may remove any packages
# that depend on firewalld. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "firewalld" ; then
dnf remove -y --noautoremove "firewalld"
fi
