# platform = multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_almalinux

sed -i 's/gpgcheck\s*=.*/gpgcheck=1/g' /etc/yum.repos.d/*