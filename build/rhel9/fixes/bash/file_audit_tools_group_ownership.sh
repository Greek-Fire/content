# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

newgroup=""
if getent group "0" >/dev/null 2>&1; then
  newgroup="0"
fi

if [[ -z "${newgroup}" ]]; then
  >&2 echo "0 is not a defined group on the system"
else
if ! stat -c "%g %G" "/sbin/auditctl" | grep -E -w -q "0"; then
    chgrp --no-dereference "$newgroup" /sbin/auditctl
fi
if ! stat -c "%g %G" "/sbin/aureport" | grep -E -w -q "0"; then
    chgrp --no-dereference "$newgroup" /sbin/aureport
fi
if ! stat -c "%g %G" "/sbin/ausearch" | grep -E -w -q "0"; then
    chgrp --no-dereference "$newgroup" /sbin/ausearch
fi
if ! stat -c "%g %G" "/sbin/autrace" | grep -E -w -q "0"; then
    chgrp --no-dereference "$newgroup" /sbin/autrace
fi
if ! stat -c "%g %G" "/sbin/auditd" | grep -E -w -q "0"; then
    chgrp --no-dereference "$newgroup" /sbin/auditd
fi
if ! stat -c "%g %G" "/sbin/rsyslogd" | grep -E -w -q "0"; then
    chgrp --no-dereference "$newgroup" /sbin/rsyslogd
fi
if ! stat -c "%g %G" "/sbin/augenrules" | grep -E -w -q "0"; then
    chgrp --no-dereference "$newgroup" /sbin/augenrules
fi

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi