# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove libreport-plugin-logger
# from the system, and may remove any packages
# that depend on libreport-plugin-logger. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "libreport-plugin-logger" ; then
dnf remove -y --noautoremove "libreport-plugin-logger"
fi
