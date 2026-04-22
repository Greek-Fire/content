# platform = multi_platform_debian,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if ( rpm --quiet -q grub2-common && rpm --quiet -q kernel-core ); then

if { rpm --quiet -q kernel rpm-ostree bootc && ! rpm --quiet -q openshift-kubelet && { [ -f "/run/.containerenv" ] || [ -f "/.containerenv" ]; }; } ; then
    KARGS_DIR="/usr/lib/bootc/kargs.d/"
    if grep -q -E "page_alloc.shuffle" "$KARGS_DIR/*.toml" ; then
        sed -i -E "s/^(\s*kargs\s*=\s*\[.*)\"page_alloc.shuffle=[^\"]*\"(.*]\s*)/\1\"page_alloc.shuffle=1\"\2/" "$KARGS_DIR/*.toml"
    else
        echo "kargs = [\"page_alloc.shuffle=1\"]" >> "$KARGS_DIR/10-page_alloc_shuffle.toml"
    fi
else

    grubby --update-kernel=ALL --args=page_alloc.shuffle=1

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi