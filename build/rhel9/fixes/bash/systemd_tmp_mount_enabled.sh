# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if ( ! ( { rpm --quiet -q kernel-core ;} && { rpm --quiet -q rpm-ostree ;} && { rpm --quiet -q bootc ;} && { ! rpm --quiet -q openshift-kubelet ;} && ([ -f /run/ostree-booted ] || [ -L /ostree ]) ) && ! ( [ -f /.dockerenv ] || [ -f /run/.containerenv ] ) ); then

SYSTEMCTL_EXEC='/usr/bin/systemctl'
"$SYSTEMCTL_EXEC" unmask 'tmp.mount'
if [[ $("$SYSTEMCTL_EXEC" is-system-running) != "offline" ]]; then
  "$SYSTEMCTL_EXEC" start 'tmp.mount'
fi
"$SYSTEMCTL_EXEC" enable 'tmp.mount'

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi