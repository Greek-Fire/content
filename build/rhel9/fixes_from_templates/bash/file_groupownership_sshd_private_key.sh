# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newgroup=""
if getent group "ssh_keys" >/dev/null 2>&1; then
  newgroup="ssh_keys"
fi

if [[ -z "${newgroup}" ]]; then
  >&2 echo "ssh_keys is not a defined group on the system"
else
find -P /etc/ssh/ -maxdepth 1 -type f  ! -group ssh_keys -regextype posix-extended -regex '^.*_key$' -exec chgrp --no-dereference "$newgroup" {} \;

fi