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
find -P /bin/  -type d  ! -group 0 -exec chgrp --no-dereference "$newgroup" {} \;
find -P /sbin/  -type d  ! -group 0 -exec chgrp --no-dereference "$newgroup" {} \;
find -P /usr/bin/  -type d  ! -group 0 -exec chgrp --no-dereference "$newgroup" {} \;
find -P /usr/sbin/  -type d  ! -group 0 -exec chgrp --no-dereference "$newgroup" {} \;
find -P /usr/local/bin/  -type d  ! -group 0 -exec chgrp --no-dereference "$newgroup" {} \;
find -P /usr/local/sbin/  -type d  ! -group 0 -exec chgrp --no-dereference "$newgroup" {} \;

fi