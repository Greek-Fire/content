# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newgroup=""
if getent group "root" >/dev/null 2>&1; then
  newgroup="root"
fi

if [[ -z "${newgroup}" ]]; then
  >&2 echo "root is not a defined group on the system"
else
if ! stat -c "%g %G" "/etc/sestatus.conf" | grep -E -w -q "root"; then
    chgrp --no-dereference "$newgroup" /etc/sestatus.conf
fi

fi