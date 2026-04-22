# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

if [[ -f  /etc/at.deny ]]; then
        rm /etc/at.deny
    fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi