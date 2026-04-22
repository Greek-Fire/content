# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove inetutils-telnet
# from the system, and may remove any packages
# that depend on inetutils-telnet. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "inetutils-telnet" ; then
dnf remove -y --noautoremove "inetutils-telnet"
fi