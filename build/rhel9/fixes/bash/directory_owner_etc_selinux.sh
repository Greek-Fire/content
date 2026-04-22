# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

newown=""
if id "0" >/dev/null 2>&1; then
  newown="0"
fi

if [[ -z "$newown" ]]; then
  >&2 echo "0 is not a defined user on the system"
else
find -P /etc/selinux/ -maxdepth 0 -type d  ! -user 0 -exec chown --no-dereference "$newown" {} \;

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi