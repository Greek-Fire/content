# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove tnftp
# from the system, and may remove any packages
# that depend on tnftp. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "tnftp" ; then
dnf remove -y --noautoremove "tnftp"
fi