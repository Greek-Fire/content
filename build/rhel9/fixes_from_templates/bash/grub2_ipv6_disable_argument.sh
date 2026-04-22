# platform = multi_platform_debian,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu,multi_platform_almalinux


if { rpm --quiet -q kernel rpm-ostree bootc && ! rpm --quiet -q openshift-kubelet && { [ -f "/run/.containerenv" ] || [ -f "/.containerenv" ]; }; } ; then
    KARGS_DIR="/usr/lib/bootc/kargs.d/"
    if grep -q -E "ipv6.disable" "$KARGS_DIR/*.toml" ; then
        sed -i -E "s/^(\s*kargs\s*=\s*\[.*)\"ipv6.disable=[^\"]*\"(.*]\s*)/\1\"ipv6.disable=1\"\2/" "$KARGS_DIR/*.toml"
    else
        echo "kargs = [\"ipv6.disable=1\"]" >> "$KARGS_DIR/10-ipv6_disable.toml"
    fi
else

    grubby --update-kernel=ALL --args=ipv6.disable=1

fi