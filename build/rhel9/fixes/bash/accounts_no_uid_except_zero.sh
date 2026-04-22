# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

awk -F: '$3 == 0 && $1 != "root" { print $1 }' /etc/passwd | xargs --no-run-if-empty --max-lines=1 passwd -l

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi