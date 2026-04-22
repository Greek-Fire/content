# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newgroup=""
if getent group "4" >/dev/null 2>&1; then
  newgroup="4"
fi

if [[ -z "${newgroup}" ]]; then
  >&2 echo "4 is not a defined group on the system"
else
if ! stat -c "%g %G" "/var/log/syslog" | grep -E -w -q "4"; then
    chgrp --no-dereference "$newgroup" /var/log/syslog
fi

fi