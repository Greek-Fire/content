# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_almalinux,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu
# reboot = false
# strategy = disable
# complexity = low
# disruption = low


SYSTEMCTL_EXEC='/usr/bin/systemctl'
if [[ $("$SYSTEMCTL_EXEC" is-system-running) != "offline" ]]; then
  "$SYSTEMCTL_EXEC" stop 'nfslock.service'
fi
"$SYSTEMCTL_EXEC" disable 'nfslock.service'
"$SYSTEMCTL_EXEC" mask 'nfslock.service'
# Disable socket activation if we have a unit file for it
if "$SYSTEMCTL_EXEC" -q list-unit-files nfslock.socket; then
    if [[ $("$SYSTEMCTL_EXEC" is-system-running) != "offline" ]]; then
      "$SYSTEMCTL_EXEC" stop 'nfslock.socket'
    fi
    "$SYSTEMCTL_EXEC" mask 'nfslock.socket'
fi
# The service may not be running because it has been started and failed,
# so let's reset the state so OVAL checks pass.
# Service should be 'inactive', not 'failed' after reboot though.
"$SYSTEMCTL_EXEC" reset-failed 'nfslock.service' || true