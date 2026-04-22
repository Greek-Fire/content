# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

SSH_CONF="/etc/sysconfig/sshd"

sed -i "/^\s*CRYPTO_POLICY.*$/Id" $SSH_CONF

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi