# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

for user in $(awk -F':' '{ if ($3 >= 1000 && $3 != 65534) print $1 }' /etc/passwd); do
    # This follows the same logic of evaluation of home directories as used in OVAL.
    if ! grep -q $user /etc/passwd | cut -d: -f6 | grep '^\/\w*\/\w\{1,\}'; then
        sed -i "s/\($user:x:[0-9]*:[0-9]*:.*:\).*\(:.*\)$/\1\/home\/$user\2/g" /etc/passwd;
    fi
done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi