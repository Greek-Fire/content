# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_rhv,multi_platform_ubuntu,multi_platform_sle,multi_platform_slmicro,multi_platform_debian,multi_platform_almalinux
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

if ! rpm -q --quiet "firewalld" ; then
    dnf install -y "firewalld"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi