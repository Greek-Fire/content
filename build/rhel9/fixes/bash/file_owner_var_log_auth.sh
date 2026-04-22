# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newown=""
if id "syslog" >/dev/null 2>&1; then
  newown="syslog"
elif id "root" >/dev/null 2>&1; then
  newown="root"
fi

if [[ -z "$newown" ]]; then
  >&2 echo "syslog and root is not a defined user on the system"
else
if ! stat -c "%u %U" "/var/log/auth.log" | grep -E -w -q "syslog|root"; then
    chown --no-dereference "$newown" /var/log/auth.log
fi

fi