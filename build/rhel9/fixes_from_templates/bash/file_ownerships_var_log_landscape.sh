# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newown=""
if id "root" >/dev/null 2>&1; then
  newown="root"
elif id "landscape" >/dev/null 2>&1; then
  newown="landscape"
fi

if [[ -z "$newown" ]]; then
  >&2 echo "root and landscape is not a defined user on the system"
else

find -P /var/log/landscape/ -maxdepth 1 -type f  ! -user root ! -user landscape -regextype posix-extended -regex '^.*$' -exec chown --no-dereference "$newown" {} \;

fi