# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low

newown=""
if id "syslog" >/dev/null 2>&1; then
  newown="syslog"
elif id "root" >/dev/null 2>&1; then
  newown="root"
fi

if [[ -z "$newown" ]]; then
  >&2 echo "syslog and root is not a defined user on the system"
else

find -P /var/log/ -maxdepth 1 -type f  ! -user syslog ! -user root -regextype posix-extended -regex '.*secure(.*[-\.].*)?' -exec chown --no-dereference "$newown" {} \;

fi