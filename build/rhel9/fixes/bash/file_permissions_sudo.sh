# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q sudo; }; then

chmod 4110 /usr/bin/sudo

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi