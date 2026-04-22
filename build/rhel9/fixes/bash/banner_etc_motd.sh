# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

motd_banner_contents=$(echo "(bash-populate motd_banner_contents)" | sed 's/\\n/\n/g')
echo "$motd_banner_contents" > /etc/motd

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi