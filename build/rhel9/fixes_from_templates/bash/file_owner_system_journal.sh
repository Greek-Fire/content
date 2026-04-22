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
if ! stat -c "%u %U" "^/var/log/journal/.*/system.journal$" | grep -E -w -q "0"; then
    chown --no-dereference "$newown" ^/var/log/journal/.*/system.journal$
fi

fi