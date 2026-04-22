# platform = multi_platform_all
# reboot = true
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

# Check current SELinux state in config file
selinux_current_state=""
if [ -f "/etc/selinux/config" ]; then
    selinux_current_state=$(grep -oP '^\s*SELINUX=\K(enforcing|permissive|disabled)' /etc/selinux/config || true)
fi

# Only remediate if SELinux is disabled or not configured
# If already set to enforcing or permissive, it's compliant - preserve the current state
if [ "$selinux_current_state" != "enforcing" ] && [ "$selinux_current_state" != "permissive" ]; then
    # SELinux is disabled or not configured, set to permissive as a conservative approach
    if [ -e "/etc/selinux/config" ] ; then
    
    LC_ALL=C sed -i "/^SELINUX=/Id" "/etc/selinux/config"
else
    touch "/etc/selinux/config"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/selinux/config"

cp "/etc/selinux/config" "/etc/selinux/config.bak"
# Insert at the end of the file
printf '%s\n' "SELINUX=permissive" >> "/etc/selinux/config"
# Clean up after ourselves.
rm "/etc/selinux/config.bak"
    fixfiles onboot
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi