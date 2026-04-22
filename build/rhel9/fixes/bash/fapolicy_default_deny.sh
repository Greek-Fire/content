# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

cat > /etc/fapolicyd/rules.d/99-deny-everything.rules << EOF
# Red Hat KCS 7003854 (https://access.redhat.com/solutions/7003854)
deny perm=any all : all
EOF

chmod 644 /etc/fapolicyd/rules.d/99-deny-everything.rules
chgrp fapolicyd /etc/fapolicyd/rules.d/99-deny-everything.rules

if [ -e "/etc/fapolicyd/fapolicyd.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*permissive\s*=\s*/Id" "/etc/fapolicyd/fapolicyd.conf"
else
    touch "/etc/fapolicyd/fapolicyd.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/fapolicyd/fapolicyd.conf"

cp "/etc/fapolicyd/fapolicyd.conf" "/etc/fapolicyd/fapolicyd.conf.bak"
# Insert at the end of the file
printf '%s\n' "permissive = 0" >> "/etc/fapolicyd/fapolicyd.conf"
# Clean up after ourselves.
rm "/etc/fapolicyd/fapolicyd.conf.bak"

systemctl restart fapolicyd

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi