# platform = Red Hat Virtualization 4,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if rpm --quiet -q audit && rpm --quiet -q kernel-core; then

var_audispd_remote_server='(bash-populate var_audispd_remote_server)'


AUDITCONFIG=/etc/audit/audisp-remote.conf



if [ -e "$AUDITCONFIG" ] ; then
    
    LC_ALL=C sed -i "/^\s*remote_server\s*=\s*/Id" "$AUDITCONFIG"
else
    printf '%s\n' "Path '$AUDITCONFIG' wasn't found on this system. Refusing to continue." >&2
    return 1
fi
# make sure file has newline at the end
sed -i -e '$a\' "$AUDITCONFIG"

cp "$AUDITCONFIG" "$AUDITCONFIG.bak"
# Insert at the end of the file
printf '%s\n' "remote_server = $var_audispd_remote_server" >> "$AUDITCONFIG"
# Clean up after ourselves.
rm "$AUDITCONFIG.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi