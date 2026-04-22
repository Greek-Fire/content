# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove cyrus-imapd
# from the system, and may remove any packages
# that depend on cyrus-imapd. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "cyrus-imapd" ; then
dnf remove -y --noautoremove "cyrus-imapd"
fi