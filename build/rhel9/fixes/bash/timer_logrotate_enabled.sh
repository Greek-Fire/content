# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { ( ( grep -qP "^ID=[\"']?rhel[\"']?$" "/etc/os-release" && { real="$(grep -P "^VERSION_ID=[\"']?[\w.]+[\"']?$" /etc/os-release | sed "s/^VERSION_ID=[\"']\?\([^\"']\+\)[\"']\?$/\1/")"; expected="9"; printf "%s\n%s" "$expected" "$real" | sort -VC; } && rpm --quiet -q logrotate ) ); }; then

SYSTEMCTL_EXEC='/usr/bin/systemctl'
if [[ $("$SYSTEMCTL_EXEC" is-system-running) != "offline" ]]; then
  "$SYSTEMCTL_EXEC" start 'logrotate.timer'
fi
"$SYSTEMCTL_EXEC" enable 'logrotate.timer'

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi