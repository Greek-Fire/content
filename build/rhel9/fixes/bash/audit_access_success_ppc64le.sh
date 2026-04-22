# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { ( ( grep -sqE "^.*\.ppc64le$" /proc/sys/kernel/osrelease || grep -sqE "^ppc64le$" /proc/sys/kernel/arch; ) ); }; then

cat << 'EOF' > /etc/audit/rules.d/30-ospp-v42-3-access-success.rules
## Successful file access (any other opens) This has to go last.
## These next two are likely to result in a whole lot of events
-a always,exit -F arch=b64 -S open,openat,openat2,open_by_handle_at -F success=1 -F auid>=1000 -F auid!=unset -F key=successful-access
EOF

chmod o-rwx /etc/audit/rules.d/30-ospp-v42-3-access-success.rules

augenrules --load

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi