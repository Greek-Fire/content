# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newgroup=""
if getent group "gdm" >/dev/null 2>&1; then
  newgroup="gdm"
elif getent group "gdm3" >/dev/null 2>&1; then
  newgroup="gdm3"
elif getent group "root" >/dev/null 2>&1; then
  newgroup="root"
fi

if [[ -z "${newgroup}" ]]; then
  >&2 echo "gdm and gdm3 and root is not a defined group on the system"
else
find -P /var/log/gdm3/  -type f  ! -group gdm ! -group gdm3 ! -group root -regextype posix-extended -regex '.*' -exec chgrp --no-dereference "$newgroup" {} \;

fi