# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { ( ( grep -sqE "^.*\.ppc64le$" /proc/sys/kernel/osrelease || grep -sqE "^ppc64le$" /proc/sys/kernel/arch; ) ); }; then

cat << 'EOF' > /etc/audit/rules.d/30-ospp-v42-2-modify-success.rules
## Successful file modifications (open for write or truncate)
-a always,exit -F arch=b64 -S openat,open_by_handle_at -F a2&01003 -F success=1 -F auid>=1000 -F auid!=unset -F key=successful-modification
-a always,exit -F arch=b64 -S open -F a1&01003 -F success=1 -F auid>=1000 -F auid!=unset -F key=successful-modification
-a always,exit -F arch=b64 -S truncate,ftruncate -F success=1 -F auid>=1000 -F auid!=unset -F key=successful-modification
EOF

chmod o-rwx /etc/audit/rules.d/30-ospp-v42-2-modify-success.rules

augenrules --load

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi