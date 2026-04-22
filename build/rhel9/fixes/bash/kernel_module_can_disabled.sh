# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_almalinux,multi_platform_rhv,multi_platform_ubuntu,multi_platform_sle,multi_platform_slmicro,multi_platform_debian
# reboot = true
# strategy = disable
# complexity = low
# disruption = medium
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

if LC_ALL=C grep -q -m 1 "^install can" /etc/modprobe.d/can.conf ; then
	
	sed -i 's#^install can.*#install can /bin/false#g' /etc/modprobe.d/can.conf
else
	echo -e "\n# Disable per security requirements" >> /etc/modprobe.d/can.conf
	echo "install can /bin/false" >> /etc/modprobe.d/can.conf
fi

if ! LC_ALL=C grep -q -m 1 "^blacklist can$" /etc/modprobe.d/can.conf ; then
	echo "blacklist can" >> /etc/modprobe.d/can.conf
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi