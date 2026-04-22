# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

newgroup=""
if getent group "systemd-journal" >/dev/null 2>&1; then
  newgroup="systemd-journal"
fi

if [[ -z "${newgroup}" ]]; then
  >&2 echo "systemd-journal is not a defined group on the system"
else
find -P /run/log/journal/  -type d  ! -group systemd-journal -exec chgrp --no-dereference "$newgroup" {} \;
find -P /var/log/journal/  -type d  ! -group systemd-journal -exec chgrp --no-dereference "$newgroup" {} \;

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi