# platform = multi_platform_all
# reboot = true
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q krb5-libs; then

rm -f /etc/krb5.conf.d/crypto-policies
ln -s /etc/crypto-policies/back-ends/krb5.config /etc/krb5.conf.d/crypto-policies

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi