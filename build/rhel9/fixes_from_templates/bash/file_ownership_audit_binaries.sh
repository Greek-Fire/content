# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newown=""
if id "0" >/dev/null 2>&1; then
  newown="0"
fi

if [[ -z "$newown" ]]; then
  >&2 echo "0 is not a defined user on the system"
else
if ! stat -c "%u %U" "/sbin/auditctl" | grep -E -w -q "0"; then
    chown --no-dereference "$newown" /sbin/auditctl
fi
if ! stat -c "%u %U" "/sbin/aureport" | grep -E -w -q "0"; then
    chown --no-dereference "$newown" /sbin/aureport
fi
if ! stat -c "%u %U" "/sbin/ausearch" | grep -E -w -q "0"; then
    chown --no-dereference "$newown" /sbin/ausearch
fi
if ! stat -c "%u %U" "/sbin/autrace" | grep -E -w -q "0"; then
    chown --no-dereference "$newown" /sbin/autrace
fi
if ! stat -c "%u %U" "/sbin/auditd" | grep -E -w -q "0"; then
    chown --no-dereference "$newown" /sbin/auditd
fi
if ! stat -c "%u %U" "/sbin/augenrules" | grep -E -w -q "0"; then
    chown --no-dereference "$newown" /sbin/augenrules
fi
if ! stat -c "%u %U" "/sbin/audisp-syslog" | grep -E -w -q "0"; then
    chown --no-dereference "$newown" /sbin/audisp-syslog
fi

fi