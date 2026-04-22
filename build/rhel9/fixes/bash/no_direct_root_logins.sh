# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

echo > /etc/securetty

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi