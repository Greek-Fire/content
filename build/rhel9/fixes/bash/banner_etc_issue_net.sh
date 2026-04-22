# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

remote_login_banner_contents=$(echo "(bash-populate remote_login_banner_contents)" | sed 's/\\n/\n/g')
echo "$remote_login_banner_contents" > /etc/issue.net

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi