# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q iptables; then

sed -i 's/^:FORWARD ACCEPT.*/:FORWARD DROP [0:0]/g' /etc/sysconfig/iptables

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi