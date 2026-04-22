# platform = Red Hat Enterprise Linux 8,Red Hat Enterprise Linux 9
# Remediation is applicable only in certain platforms
if ( grep -sqE "^.*\.s390x$" /proc/sys/kernel/osrelease || grep -sqE "^s390x$" /proc/sys/kernel/arch; ) && { ( [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ] ); }; then

# Correct BLS option using grubby, which is a thin wrapper around BLS operations
grubby --update-kernel=ALL --remove-args="systemd.debug-shell"

# Ensure new kernels and boot entries retain the boot option
if grep -q '\bsystemd.debug-shell\b' /etc/kernel/cmdline; then
    sed -Ei 's/^(.*)\s*systemd.debug-shell\b\S*(.*)/\1\2/' /etc/kernel/cmdline
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi