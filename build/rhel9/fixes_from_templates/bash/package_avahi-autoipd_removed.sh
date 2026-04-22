# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove avahi-autoipd
# from the system, and may remove any packages
# that depend on avahi-autoipd. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "avahi-autoipd" ; then
dnf remove -y --noautoremove "avahi-autoipd"
fi
