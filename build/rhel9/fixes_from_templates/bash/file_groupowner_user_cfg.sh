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
if ! stat -c "%g %G" "/boot/grub2/user.cfg" | grep -E -w -q "0"; then
    chgrp --no-dereference "$newgroup" /boot/grub2/user.cfg
fi

fi