# platform = Red Hat Virtualization 4,multi_platform_rhel,multi_platform_ol,multi_platform_ubuntu,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if rpm --quiet -q tcsh; then

var_accounts_user_umask='(bash-populate var_accounts_user_umask)'


grep -q "^\s*umask" /etc/csh.cshrc && \
  sed -i -E -e "s/^(\s*umask).*/\1 $var_accounts_user_umask/g" /etc/csh.cshrc
if ! [ $? -eq 0 ]; then
    echo "umask $var_accounts_user_umask" >> /etc/csh.cshrc
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi