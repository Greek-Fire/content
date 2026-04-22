# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if ( ( rpm --quiet -q pam && rpm --quiet -q kernel-core ) ); then

sed -i '/pam_succeed_if/d' /etc/pam.d/sudo

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi