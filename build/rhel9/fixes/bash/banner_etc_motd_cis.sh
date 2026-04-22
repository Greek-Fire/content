# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

cis_banner_text='(bash-populate cis_banner_text)'

echo "$cis_banner_text" > "/etc/motd"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi