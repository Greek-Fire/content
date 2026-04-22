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
find -P /boot/ -maxdepth 1 -type f  ! -group root -regextype posix-extended -regex '^.*System\.map.*$' -exec chgrp --no-dereference "$newgroup" {} \;

fi