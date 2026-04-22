# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if ( ( ! ( [ "${container:-}" == "bwrap-osbuild" ] ) && rpm --quiet -q kernel-core ) ); then

if { rpm --quiet -q kernel rpm-ostree bootc && ! rpm --quiet -q openshift-kubelet && { [ -f "/run/.containerenv" ] || [ -f "/.containerenv" ]; }; }; then
	cat > /usr/lib/bootc/kargs.d/01-fips.toml << EOF
kargs = ["fips=1"]
EOF
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi