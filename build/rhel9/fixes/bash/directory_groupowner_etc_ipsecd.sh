# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q libreswan; then

newgroup=""
if getent group "root" >/dev/null 2>&1; then
  newgroup="root"
fi

if [[ -z "${newgroup}" ]]; then
  >&2 echo "root is not a defined group on the system"
else
find -P /etc/ipsec.d/ -maxdepth 0 -type d  ! -group root -exec chgrp --no-dereference "$newgroup" {} \;

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi