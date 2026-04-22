# platform = multi_platform_debian,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu,multi_platform_almalinux
var_rng_core_default_quality='(bash-populate var_rng_core_default_quality)'



if { rpm --quiet -q kernel rpm-ostree bootc && ! rpm --quiet -q openshift-kubelet && { [ -f "/run/.containerenv" ] || [ -f "/.containerenv" ]; }; } ; then
    KARGS_DIR="/usr/lib/bootc/kargs.d/"
    if grep -q -E "rng_core.default_quality" "$KARGS_DIR/*.toml" ; then
        sed -i -E "s/^(\s*kargs\s*=\s*\[.*)\"rng_core.default_quality=[^\"]*\"(.*]\s*)/\1\"rng_core.default_quality=$var_rng_core_default_quality\"\2/" "$KARGS_DIR/*.toml"
    else
        echo "kargs = [\"rng_core.default_quality=$var_rng_core_default_quality\"]" >> "$KARGS_DIR/10-rng_core_default_quality.toml"
    fi
else

    grubby --update-kernel=ALL --args=rng_core.default_quality=$var_rng_core_default_quality

fi