# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if ( rpm --quiet -q grub2-common && rpm --quiet -q kernel-core ) && { ( ! ( [ -f /.dockerenv ] || [ -f /run/.containerenv ] ) ); }; then

newgroup=""
if getent group "0" >/dev/null 2>&1; then
  newgroup="0"
fi

if [[ -z "${newgroup}" ]]; then
  >&2 echo "0 is not a defined group on the system"
else
if ! stat -c "%g %G" "/boot/grub2/user.cfg" | grep -E -w -q "0"; then
    chgrp --no-dereference "$newgroup" /boot/grub2/user.cfg
fi

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi