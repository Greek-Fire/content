# platform = multi_platform_all
# reboot = true
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if ( ( rpm --quiet -q kernel-core && ( grep -sqE "^.*\.x86_64$" /proc/sys/kernel/osrelease || grep -sqE "^x86_64$" /proc/sys/kernel/arch; ) ) ); then

grubby --update-kernel=ALL --remove-args=noexec

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi