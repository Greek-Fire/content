# platform = multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_sle,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if ( ( rpm --quiet -q pam && rpm --quiet -q kernel-core ) ); then

if ! grep -Eq '^\s*session\s+required\s+pam_namespace.so\s*$' '/etc/pam.d/login' ; then
    echo "session    required     pam_namespace.so" >> "/etc/pam.d/login"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi