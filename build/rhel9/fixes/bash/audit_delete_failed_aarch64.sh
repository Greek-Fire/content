# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { ( ( grep -sqE "^.*\.aarch64$" /proc/sys/kernel/osrelease || grep -sqE "^aarch64$" /proc/sys/kernel/arch; ) ); }; then

cat << 'EOF' > /etc/audit/rules.d/30-ospp-v42-4-delete-failed.rules
## Unsuccessful file delete
-a always,exit -F arch=b32 -S unlink,unlinkat,rename,renameat -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=unsuccessful-delete
-a always,exit -F arch=b64 -S unlinkat,renameat -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=unsuccessful-delete
-a always,exit -F arch=b32 -S unlink,unlinkat,rename,renameat -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=unsuccessful-delete
-a always,exit -F arch=b64 -S unlinkat,renameat -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=unsuccessful-delete
EOF

chmod o-rwx /etc/audit/rules.d/30-ospp-v42-4-delete-failed.rules

augenrules --load

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi