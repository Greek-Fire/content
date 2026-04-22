# platform = multi_platform_debian,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu,multi_platform_almalinux


if { rpm --quiet -q kernel rpm-ostree bootc && ! rpm --quiet -q openshift-kubelet && { [ -f "/run/.containerenv" ] || [ -f "/.containerenv" ]; }; } ; then
    KARGS_DIR="/usr/lib/bootc/kargs.d/"
    if grep -q -E "mce" "$KARGS_DIR/*.toml" ; then
        sed -i -E "s/^(\s*kargs\s*=\s*\[.*)\"mce=[^\"]*\"(.*]\s*)/\1\"mce=0\"\2/" "$KARGS_DIR/*.toml"
    else
        echo "kargs = [\"mce=0\"]" >> "$KARGS_DIR/10-mce.toml"
    fi
else

    grubby --update-kernel=ALL --args=mce=0

fi