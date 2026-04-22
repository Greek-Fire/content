# platform = multi_platform_debian,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if ( rpm --quiet -q grub2-common && rpm --quiet -q kernel-core ) && { ( ( grep -sqE "^.*\.x86_64$" /proc/sys/kernel/osrelease || grep -sqE "^x86_64$" /proc/sys/kernel/arch; ) ); }; then

if { rpm --quiet -q kernel rpm-ostree bootc && ! rpm --quiet -q openshift-kubelet && { [ -f "/run/.containerenv" ] || [ -f "/.containerenv" ]; }; } ; then
    KARGS_DIR="/usr/lib/bootc/kargs.d/"
    if grep -q -E "vsyscall" "$KARGS_DIR/*.toml" ; then
        sed -i -E "s/^(\s*kargs\s*=\s*\[.*)\"vsyscall=[^\"]*\"(.*]\s*)/\1\"vsyscall=none\"\2/" "$KARGS_DIR/*.toml"
    else
        echo "kargs = [\"vsyscall=none\"]" >> "$KARGS_DIR/10-vsyscall.toml"
    fi
else

    grubby --update-kernel=ALL --args=vsyscall=none

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi