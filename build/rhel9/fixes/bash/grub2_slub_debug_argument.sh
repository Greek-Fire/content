# platform = multi_platform_debian,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q grub2-common; }; then

var_slub_debug_options='(bash-populate var_slub_debug_options)'



if { rpm --quiet -q kernel rpm-ostree bootc && ! rpm --quiet -q openshift-kubelet && { [ -f "/run/.containerenv" ] || [ -f "/.containerenv" ]; }; } ; then
    KARGS_DIR="/usr/lib/bootc/kargs.d/"
    if grep -q -E "slub_debug" "$KARGS_DIR/*.toml" ; then
        sed -i -E "s/^(\s*kargs\s*=\s*\[.*)\"slub_debug=[^\"]*\"(.*]\s*)/\1\"slub_debug=$var_slub_debug_options\"\2/" "$KARGS_DIR/*.toml"
    else
        echo "kargs = [\"slub_debug=$var_slub_debug_options\"]" >> "$KARGS_DIR/10-slub_debug.toml"
    fi
else

    grubby --update-kernel=ALL --args=slub_debug=$var_slub_debug_options

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi