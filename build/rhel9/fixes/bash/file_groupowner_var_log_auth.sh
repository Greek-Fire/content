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
if ! stat -c "%g %G" "/var/log/auth.log" | grep -E -w -q "adm|root"; then
    chgrp --no-dereference "$newgroup" /var/log/auth.log
fi

fi