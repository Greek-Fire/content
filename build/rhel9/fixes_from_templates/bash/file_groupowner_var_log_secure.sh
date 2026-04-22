# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newgroup=""
if getent group "adm" >/dev/null 2>&1; then
  newgroup="adm"
elif getent group "root" >/dev/null 2>&1; then
  newgroup="root"
fi

if [[ -z "${newgroup}" ]]; then
  >&2 echo "adm and root is not a defined group on the system"
else
find -P /var/log/ -maxdepth 1 -type f  ! -group adm ! -group root -regextype posix-extended -regex '.*secure(.*[-\.].*)?' -exec chgrp --no-dereference "$newgroup" {} \;

fi