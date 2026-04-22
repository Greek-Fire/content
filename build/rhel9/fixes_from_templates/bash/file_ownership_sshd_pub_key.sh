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

find -P /etc/ssh/ -maxdepth 1 -type f  ! -user 0 -regextype posix-extended -regex '^.*\.pub$' -exec chown --no-dereference "$newown" {} \;

fi