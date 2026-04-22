# platform = multi_platform_debian,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu,multi_platform_almalinux
var_l1tf_options='(bash-populate var_l1tf_options)'



if { rpm --quiet -q kernel rpm-ostree bootc && ! rpm --quiet -q openshift-kubelet && { [ -f "/run/.containerenv" ] || [ -f "/.containerenv" ]; }; } ; then
    KARGS_DIR="/usr/lib/bootc/kargs.d/"
    if grep -q -E "l1tf" "$KARGS_DIR/*.toml" ; then
        sed -i -E "s/^(\s*kargs\s*=\s*\[.*)\"l1tf=[^\"]*\"(.*]\s*)/\1\"l1tf=$var_l1tf_options\"\2/" "$KARGS_DIR/*.toml"
    else
        echo "kargs = [\"l1tf=$var_l1tf_options\"]" >> "$KARGS_DIR/10-l1tf.toml"
    fi
else

    grubby --update-kernel=ALL --args=l1tf=$var_l1tf_options

fi