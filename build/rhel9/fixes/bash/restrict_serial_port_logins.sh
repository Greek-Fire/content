# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

sed -i '/ttyS/d' /etc/securetty

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi