# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

sed -i '/^vc\/[0-9]/d' /etc/securetty

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi