# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_almalinux,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu
# reboot = false
# strategy = disable
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

SYSTEMCTL_EXEC='/usr/bin/systemctl'
if [[ $("$SYSTEMCTL_EXEC" is-system-running) != "offline" ]]; then
  "$SYSTEMCTL_EXEC" stop 'rlogin.service'
fi
"$SYSTEMCTL_EXEC" disable 'rlogin.service'
"$SYSTEMCTL_EXEC" mask 'rlogin.service'
# Disable socket activation if we have a unit file for it
if "$SYSTEMCTL_EXEC" -q list-unit-files rlogin.socket; then
    if [[ $("$SYSTEMCTL_EXEC" is-system-running) != "offline" ]]; then
      "$SYSTEMCTL_EXEC" stop 'rlogin.socket'
    fi
    "$SYSTEMCTL_EXEC" mask 'rlogin.socket'
fi
# The service may not be running because it has been started and failed,
# so let's reset the state so OVAL checks pass.
# Service should be 'inactive', not 'failed' after reboot though.
"$SYSTEMCTL_EXEC" reset-failed 'rlogin.service' || true

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi