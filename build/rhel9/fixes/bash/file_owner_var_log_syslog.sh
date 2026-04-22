# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q rsyslog; then

newown=""
if id "syslog" >/dev/null 2>&1; then
  newown="syslog"
fi

if [[ -z "$newown" ]]; then
  >&2 echo "syslog is not a defined user on the system"
else
if ! stat -c "%u %U" "/var/log/syslog" | grep -E -w -q "syslog"; then
    chown --no-dereference "$newown" /var/log/syslog
fi

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi