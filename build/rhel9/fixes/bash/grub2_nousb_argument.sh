# platform = multi_platform_debian,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if rpm --quiet -q grub2-common; then

if { rpm --quiet -q kernel rpm-ostree bootc && ! rpm --quiet -q openshift-kubelet && { [ -f "/run/.containerenv" ] || [ -f "/.containerenv" ]; }; } ; then
    KARGS_DIR="/usr/lib/bootc/kargs.d/"
    if grep -q -E "nousb" "$KARGS_DIR/*.toml" ; then
        sed -i -E "s/^(\s*kargs\s*=\s*\[.*)\"nousb=[^\"]*\"(.*]\s*)/\1\"nousb\"\2/" "$KARGS_DIR/*.toml"
    else
        echo "kargs = [\"nousb\"]" >> "$KARGS_DIR/10-nousb.toml"
    fi
else

    grubby --update-kernel=ALL --args=nousb

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi