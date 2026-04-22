# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q gdm && { rpm --quiet -q kernel-core; }; then

dconf update

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi