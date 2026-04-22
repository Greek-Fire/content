# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

for user in $(awk -F':' '{ if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd); do
    mkhomedir_helper $user 0077;
done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi