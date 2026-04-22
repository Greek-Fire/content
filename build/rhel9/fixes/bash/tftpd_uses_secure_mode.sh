# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q tftp-server; then

var_tftpd_secure_directory='(bash-populate var_tftpd_secure_directory)'


if grep -q 'server_args' /etc/xinetd.d/tftp; then
    sed -i -E "s;^([[:blank:]]*server_args[[:blank:]]+=[[:blank:]]+.*?)(-s[[:blank:]]+[[:graph:]]+)*(.*)$;\1 -s $var_tftpd_secure_directory \3;" /etc/xinetd.d/tftp
else
    echo "server_args = -s $var_tftpd_secure_directory" >> /etc/xinetd.d/tftp
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi