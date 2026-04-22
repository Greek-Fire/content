# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { ( ( grep -sqE "^.*\.ppc64le$" /proc/sys/kernel/osrelease || grep -sqE "^ppc64le$" /proc/sys/kernel/arch; ) ); }; then

cat << 'EOF' > /etc/audit/rules.d/30-ospp-v42-3-access-failed.rules
## Unsuccessful file access (any other opens) This has to go last.
-a always,exit -F arch=b64 -S open,openat,openat2,open_by_handle_at -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=unsuccessful-access
-a always,exit -F arch=b64 -S open,openat,openat2,open_by_handle_at -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=unsuccessful-access
EOF

chmod o-rwx /etc/audit/rules.d/30-ospp-v42-3-access-failed.rules

augenrules --load

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi