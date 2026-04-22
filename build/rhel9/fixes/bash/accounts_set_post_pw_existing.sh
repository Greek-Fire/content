# platform = multi_platform_all
# complexity = low
# disruption = low
# reboot = false
# strategy = restrict
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

var_account_disable_post_pw_expiration='(bash-populate var_account_disable_post_pw_expiration)'


while IFS= read -r i; do
    chage --inactive $var_account_disable_post_pw_expiration $i
done <   <(awk -v var="$var_account_disable_post_pw_expiration" -F: '(($7 > var || $7 == "") && $2 ~ /^\$/) {print $1}' /etc/shadow)

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi