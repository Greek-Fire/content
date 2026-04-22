# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

# CAUTION: This remediation script will remove ufw
# from the system, and may remove any packages
# that depend on ufw. Execute this
# remediation AFTER testing on a non-production
# system!


if rpm -q --quiet "ufw" ; then
dnf remove -y --noautoremove "ufw"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi