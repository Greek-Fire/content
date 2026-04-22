# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if ( ( ! ( rpm --quiet -q nftables ) && ! ( rpm --quiet -q ufw ) && rpm --quiet -q iptables ) ); then

sed -i 's/^:INPUT ACCEPT.*/:INPUT DROP [0:0]/g' /etc/sysconfig/ip6tables

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi