# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove nginx
# from the system, and may remove any packages
# that depend on nginx. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "nginx" ; then
dnf remove -y --noautoremove "nginx"
fi
