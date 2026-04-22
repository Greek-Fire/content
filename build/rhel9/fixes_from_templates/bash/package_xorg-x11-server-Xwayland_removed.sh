# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

# CAUTION: This remediation script will remove xorg-x11-server-Xwayland
# from the system, and may remove any packages
# that depend on xorg-x11-server-Xwayland. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "xorg-x11-server-Xwayland" ; then
dnf remove -y --noautoremove "xorg-x11-server-Xwayland"
fi
