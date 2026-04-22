# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

touch /etc/at.allow
    chown 0 /etc/at.allow
    chmod 0640 /etc/at.allow

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi