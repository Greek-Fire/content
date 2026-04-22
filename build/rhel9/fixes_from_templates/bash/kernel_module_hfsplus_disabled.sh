# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_almalinux,multi_platform_rhv,multi_platform_ubuntu,multi_platform_sle,multi_platform_slmicro,multi_platform_debian
# reboot = true
# strategy = disable
# complexity = low
# disruption = medium
if LC_ALL=C grep -q -m 1 "^install hfsplus" /etc/modprobe.d/hfsplus.conf ; then
	
	sed -i 's#^install hfsplus.*#install hfsplus /bin/false#g' /etc/modprobe.d/hfsplus.conf
else
	echo -e "\n# Disable per security requirements" >> /etc/modprobe.d/hfsplus.conf
	echo "install hfsplus /bin/false" >> /etc/modprobe.d/hfsplus.conf
fi

if ! LC_ALL=C grep -q -m 1 "^blacklist hfsplus$" /etc/modprobe.d/hfsplus.conf ; then
	echo "blacklist hfsplus" >> /etc/modprobe.d/hfsplus.conf
fi
