# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newown=""
if id "sssd" >/dev/null 2>&1; then
  newown="sssd"
elif id "root" >/dev/null 2>&1; then
  newown="root"
fi

if [[ -z "$newown" ]]; then
  >&2 echo "sssd and root is not a defined user on the system"
else

find -P /var/log/sssd/  -type f  ! -user sssd ! -user root -regextype posix-extended -regex '.*' -exec chown --no-dereference "$newown" {} \;

fi