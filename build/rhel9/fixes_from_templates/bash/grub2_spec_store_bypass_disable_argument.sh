# platform = multi_platform_debian,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu,multi_platform_almalinux
var_spec_store_bypass_disable_options='(bash-populate var_spec_store_bypass_disable_options)'



if { rpm --quiet -q kernel rpm-ostree bootc && ! rpm --quiet -q openshift-kubelet && { [ -f "/run/.containerenv" ] || [ -f "/.containerenv" ]; }; } ; then
    KARGS_DIR="/usr/lib/bootc/kargs.d/"
    if grep -q -E "spec_store_bypass_disable" "$KARGS_DIR/*.toml" ; then
        sed -i -E "s/^(\s*kargs\s*=\s*\[.*)\"spec_store_bypass_disable=[^\"]*\"(.*]\s*)/\1\"spec_store_bypass_disable=$var_spec_store_bypass_disable_options\"\2/" "$KARGS_DIR/*.toml"
    else
        echo "kargs = [\"spec_store_bypass_disable=$var_spec_store_bypass_disable_options\"]" >> "$KARGS_DIR/10-spec_store_bypass_disable.toml"
    fi
else

    grubby --update-kernel=ALL --args=spec_store_bypass_disable=$var_spec_store_bypass_disable_options

fi