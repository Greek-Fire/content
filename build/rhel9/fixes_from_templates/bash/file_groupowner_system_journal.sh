# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newgroup=""
if getent group "systemd-journal" >/dev/null 2>&1; then
  newgroup="systemd-journal"
fi

if [[ -z "${newgroup}" ]]; then
  >&2 echo "systemd-journal is not a defined group on the system"
else
if ! stat -c "%g %G" "^/var/log/journal/.*/system.journal$" | grep -E -w -q "systemd-journal"; then
    chgrp --no-dereference "$newgroup" ^/var/log/journal/.*/system.journal$
fi

fi