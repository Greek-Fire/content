# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_almalinux,multi_platform_rhv,multi_platform_ubuntu,multi_platform_sle,multi_platform_slmicro,multi_platform_debian
# reboot = true
# strategy = disable
# complexity = low
# disruption = medium
if LC_ALL=C grep -q -m 1 "^install vfat" /etc/modprobe.d/vfat.conf ; then
	
	sed -i 's#^install vfat.*#install vfat /bin/false#g' /etc/modprobe.d/vfat.conf
else
	echo -e "\n# Disable per security requirements" >> /etc/modprobe.d/vfat.conf
	echo "install vfat /bin/false" >> /etc/modprobe.d/vfat.conf
fi

if ! LC_ALL=C grep -q -m 1 "^blacklist vfat$" /etc/modprobe.d/vfat.conf ; then
	echo "blacklist vfat" >> /etc/modprobe.d/vfat.conf
fi
