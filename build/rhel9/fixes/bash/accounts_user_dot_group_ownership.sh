# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

awk -F: '{if ($4 >= 1000 && $4 != 65534) print $4":"$6}' /etc/passwd | while IFS=: read -r gid home; do find -P "$home" -maxdepth 1 -type f -name "\.[^.]*" -exec chgrp -f --no-dereference -- $gid "{}" \;; done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi