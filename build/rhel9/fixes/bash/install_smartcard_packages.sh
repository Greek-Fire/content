# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_rhv,multi_platform_ubuntu,multi_platform_sle,multi_platform_slmicro,multi_platform_debian,multi_platform_almalinux
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { ( ! ( grep -sqE "^.*\.s390x$" /proc/sys/kernel/osrelease || grep -sqE "^s390x$" /proc/sys/kernel/arch; ) ); }; then

if ! rpm -q --quiet "openssl-pkcs11" ; then
    dnf install -y "openssl-pkcs11"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi