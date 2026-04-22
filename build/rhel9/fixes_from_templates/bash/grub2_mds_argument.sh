# platform = multi_platform_debian,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu,multi_platform_almalinux
var_mds_options='(bash-populate var_mds_options)'



if { rpm --quiet -q kernel rpm-ostree bootc && ! rpm --quiet -q openshift-kubelet && { [ -f "/run/.containerenv" ] || [ -f "/.containerenv" ]; }; } ; then
    KARGS_DIR="/usr/lib/bootc/kargs.d/"
    if grep -q -E "mds" "$KARGS_DIR/*.toml" ; then
        sed -i -E "s/^(\s*kargs\s*=\s*\[.*)\"mds=[^\"]*\"(.*]\s*)/\1\"mds=$var_mds_options\"\2/" "$KARGS_DIR/*.toml"
    else
        echo "kargs = [\"mds=$var_mds_options\"]" >> "$KARGS_DIR/10-mds.toml"
    fi
else

    grubby --update-kernel=ALL --args=mds=$var_mds_options

fi