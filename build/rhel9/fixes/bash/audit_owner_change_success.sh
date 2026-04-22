# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { ( ( ! ( ( grep -sqE "^.*\.aarch64$" /proc/sys/kernel/osrelease || grep -sqE "^aarch64$" /proc/sys/kernel/arch; ) ) && ! ( ( grep -sqE "^.*\.ppc64le$" /proc/sys/kernel/osrelease || grep -sqE "^ppc64le$" /proc/sys/kernel/arch; ) ) ) ); }; then

cat << 'EOF' > /etc/audit/rules.d/30-ospp-v42-6-owner-change-success.rules
## Successful ownership change
-a always,exit -F arch=b32 -S lchown,fchown,chown,fchownat -F success=1 -F auid>=1000 -F auid!=unset -F key=successful-owner-change
-a always,exit -F arch=b64 -S lchown,fchown,chown,fchownat -F success=1 -F auid>=1000 -F auid!=unset -F key=successful-owner-change
EOF

chmod o-rwx /etc/audit/rules.d/30-ospp-v42-6-owner-change-success.rules

augenrules --load

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi