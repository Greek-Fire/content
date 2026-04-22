# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newown=""
if id "0" >/dev/null 2>&1; then
  newown="0"
fi

if [[ -z "$newown" ]]; then
  >&2 echo "0 is not a defined user on the system"
else
find -P /bin/  -type d  ! -user 0 -exec chown --no-dereference "$newown" {} \;
find -P /sbin/  -type d  ! -user 0 -exec chown --no-dereference "$newown" {} \;
find -P /usr/bin/  -type d  ! -user 0 -exec chown --no-dereference "$newown" {} \;
find -P /usr/sbin/  -type d  ! -user 0 -exec chown --no-dereference "$newown" {} \;
find -P /usr/local/bin/  -type d  ! -user 0 -exec chown --no-dereference "$newown" {} \;
find -P /usr/local/sbin/  -type d  ! -user 0 -exec chown --no-dereference "$newown" {} \;

fi