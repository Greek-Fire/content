# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q audit && rpm --quiet -q kernel-core; then

newown=""
if id "0" >/dev/null 2>&1; then
  newown="0"
fi

if [[ -z "$newown" ]]; then
  >&2 echo "0 is not a defined user on the system"
else

find -P /etc/audit/ -maxdepth 1 -type f  ! -user 0 -regextype posix-extended -regex '^.*audit(\.rules|d\.conf)$' -exec chown --no-dereference "$newown" {} \;

find -P /etc/audit/rules.d/ -maxdepth 1 -type f  ! -user 0 -regextype posix-extended -regex '^.*\.rules$' -exec chown --no-dereference "$newown" {} \;

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi