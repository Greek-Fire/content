# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

login_banner_contents=$(echo "(bash-populate login_banner_contents)" | sed 's/\\n/\n/g')
echo "$login_banner_contents" > /etc/issue

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi