# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

awk -F: '{if ($3 >= 1000 && $3 != 65534) print $3":"$6}' /etc/passwd | while IFS=: read -r uid home; do find -P "$home" -maxdepth 1 -type f -name "\.[^.]*" -exec chown -f --no-dereference -- $uid "{}" \;; done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi