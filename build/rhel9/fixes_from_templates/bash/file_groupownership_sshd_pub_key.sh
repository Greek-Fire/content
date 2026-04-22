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
find -P /etc/ssh/ -maxdepth 1 -type f  ! -group 0 -regextype posix-extended -regex '^.*\.pub$' -exec chgrp --no-dereference "$newgroup" {} \;

fi