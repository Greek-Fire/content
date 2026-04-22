# platform = multi_platform_slmicro,multi_platform_rhel,multi_platform_fedora
# Remediation is applicable only in certain platforms
if rpm --quiet -q pam; then

# Create /etc/security/opasswd if needed
# Owner group mode root.root 0600
[ -f  /etc/security/opasswd ] || touch /etc/security/opasswd
chown root:root /etc/security/opasswd
chmod 0600 /etc/security/opasswd

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi