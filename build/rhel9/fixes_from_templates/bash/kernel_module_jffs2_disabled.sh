# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_almalinux,multi_platform_rhv,multi_platform_ubuntu,multi_platform_sle,multi_platform_slmicro,multi_platform_debian
# reboot = true
# strategy = disable
# complexity = low
# disruption = medium
if LC_ALL=C grep -q -m 1 "^install jffs2" /etc/modprobe.d/jffs2.conf ; then
	
	sed -i 's#^install jffs2.*#install jffs2 /bin/false#g' /etc/modprobe.d/jffs2.conf
else
	echo -e "\n# Disable per security requirements" >> /etc/modprobe.d/jffs2.conf
	echo "install jffs2 /bin/false" >> /etc/modprobe.d/jffs2.conf
fi

if ! LC_ALL=C grep -q -m 1 "^blacklist jffs2$" /etc/modprobe.d/jffs2.conf ; then
	echo "blacklist jffs2" >> /etc/modprobe.d/jffs2.conf
fi
