# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newgroup=""
if getent group "0" >/dev/null 2>&1; then
  newgroup="0"
fi

if [[ -z "${newgroup}" ]]; then
  >&2 echo "0 is not a defined group on the system"
else
if ! stat -c "%g %G" "/usr/bin/lastlog" | grep -E -w -q "0"; then
    chgrp --no-dereference "$newgroup" /usr/bin/lastlog
fi

fi