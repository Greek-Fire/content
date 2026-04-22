# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_almalinux,multi_platform_rhv,multi_platform_ubuntu,multi_platform_sle,multi_platform_slmicro,multi_platform_debian
# reboot = true
# strategy = disable
# complexity = low
# disruption = medium
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

if LC_ALL=C grep -q -m 1 "^install freevxfs" /etc/modprobe.d/freevxfs.conf ; then
	
	sed -i 's#^install freevxfs.*#install freevxfs /bin/false#g' /etc/modprobe.d/freevxfs.conf
else
	echo -e "\n# Disable per security requirements" >> /etc/modprobe.d/freevxfs.conf
	echo "install freevxfs /bin/false" >> /etc/modprobe.d/freevxfs.conf
fi

if ! LC_ALL=C grep -q -m 1 "^blacklist freevxfs$" /etc/modprobe.d/freevxfs.conf ; then
	echo "blacklist freevxfs" >> /etc/modprobe.d/freevxfs.conf
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi