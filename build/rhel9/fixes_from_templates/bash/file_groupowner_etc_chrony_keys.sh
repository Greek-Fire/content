# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newgroup=""
if getent group "chrony" >/dev/null 2>&1; then
  newgroup="chrony"
fi

if [[ -z "${newgroup}" ]]; then
  >&2 echo "chrony is not a defined group on the system"
else
if ! stat -c "%g %G" "/etc/chrony.keys" | grep -E -w -q "chrony"; then
    chgrp --no-dereference "$newgroup" /etc/chrony.keys
fi

fi