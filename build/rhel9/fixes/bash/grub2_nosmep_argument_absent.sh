# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_almalinux,multi_platform_rhv,multi_platform_ubuntu,multi_platform_sle
# Remediation is applicable only in certain platforms
if ( rpm --quiet -q grub2-common && rpm --quiet -q kernel-core ); then

if { rpm --quiet -q kernel rpm-ostree bootc && ! rpm --quiet -q openshift-kubelet && { [ -f "/run/.containerenv" ] || [ -f "/.containerenv" ]; }; } ; then
    sed -i -E "/kargs\s*=\s*\[\s*\"nosmep=[^\"]*\"\s*]/{:a;N;/^\n$/ba;N;/match-architectures.*/d;}" "$KARGS_DIR/*.toml"
    sed -i -E -e "s/^(\s*kargs\s*=\s*\[.*)\"nosmep=[^\"]*\"[,[:space:]]*(.*]\s*)/\1\2/" -e "s/^(\s*kargs.*),\s*\]$/\1\]/" "$KARGS_DIR/*.toml"
else

grubby --update-kernel=ALL --remove-args=nosmep

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi