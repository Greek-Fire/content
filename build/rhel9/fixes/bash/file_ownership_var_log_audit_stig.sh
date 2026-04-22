# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q audit && rpm --quiet -q kernel-core; then

if LC_ALL=C grep -iw log_file /etc/audit/auditd.conf; then
    FILE=$(awk -F "=" '/^log_file/ {print $2}' /etc/audit/auditd.conf | tr -d ' ')
    chown root $FILE*
else
    chown root /var/log/audit/audit.log*
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi