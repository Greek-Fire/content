# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newgroup=""
if getent group "systemd-journal" >/dev/null 2>&1; then
  newgroup="systemd-journal"
elif getent group "root" >/dev/null 2>&1; then
  newgroup="root"
fi

if [[ -z "${newgroup}" ]]; then
  >&2 echo "systemd-journal and root is not a defined group on the system"
else
find -P /var/log/  -type f  ! -group systemd-journal ! -group root -regextype posix-extended -regex '.*\.journal[~]?' -exec chgrp --no-dereference "$newgroup" {} \;

fi