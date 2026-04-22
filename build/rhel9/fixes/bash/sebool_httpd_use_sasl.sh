# platform = multi_platform_almalinux,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,SUSE Linux Enterprise 15,SUSE Linux Enterprise 16
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if ( { rpm --quiet -q kernel-core ;} && { rpm --quiet -q rpm-ostree ;} && { rpm --quiet -q bootc ;} && { ! rpm --quiet -q openshift-kubelet ;} && ([ -f /run/ostree-booted ] || [ -L /ostree ]) || [ "${container:-}" == "bwrap-osbuild" ] || selinuxenabled ) && rpm --quiet -q kernel-core; then

if ! rpm -q --quiet "python3-libsemanage" ; then
    dnf install -y "python3-libsemanage"
fi


# Workaround for https://github.com/OpenSCAP/openscap/issues/2242: Use full
# path to setsebool command to avoid the issue with the command not being
# found.

    var_httpd_use_sasl='(bash-populate var_httpd_use_sasl)'

    /usr/sbin/setsebool -P httpd_use_sasl $var_httpd_use_sasl

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi