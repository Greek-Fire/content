# platform = multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu,multi_platform_almalinux,multi_platform_debian
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { ( ( [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ] && rpm --quiet -q systemd-journal-remote ) ); }; then

SYSTEMCTL_EXEC='/usr/bin/systemctl'
"$SYSTEMCTL_EXEC" unmask 'systemd-journal-upload.service'
if [[ $("$SYSTEMCTL_EXEC" is-system-running) != "offline" ]]; then
  "$SYSTEMCTL_EXEC" start 'systemd-journal-upload.service'
fi
"$SYSTEMCTL_EXEC" enable 'systemd-journal-upload.service'

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi