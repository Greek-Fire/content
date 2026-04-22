# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_rhv,multi_platform_ubuntu,multi_platform_sle,multi_platform_slmicro,multi_platform_debian,multi_platform_almalinux
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if ( ( ! (systemctl is-active iptables &>/dev/null) && ! (systemctl is-active ufw &>/dev/null) && rpm --quiet -q kernel-core ) ); then

if ! rpm -q --quiet "nftables" ; then
    dnf install -y "nftables"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi