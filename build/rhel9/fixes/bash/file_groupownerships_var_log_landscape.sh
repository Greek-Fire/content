# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newgroup=""
if getent group "root" >/dev/null 2>&1; then
  newgroup="root"
elif getent group "landscape" >/dev/null 2>&1; then
  newgroup="landscape"
fi

if [[ -z "${newgroup}" ]]; then
  >&2 echo "root and landscape is not a defined group on the system"
else
find -P /var/log/landscape/ -maxdepth 1 -type f  ! -group root ! -group landscape -regextype posix-extended -regex '^.*$' -exec chgrp --no-dereference "$newgroup" {} \;

fi