# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

var_password_yescrypt_cost_factor_login_defs='(bash-populate var_password_yescrypt_cost_factor_login_defs)'

if [ -e "/etc/login.defs" ] ; then
    
    LC_ALL=C sed -i "/^\s*YESCRYPT_COST_FACTOR\s*/Id" "/etc/login.defs"
else
    touch "/etc/login.defs"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/login.defs"

cp "/etc/login.defs" "/etc/login.defs.bak"
# Insert at the end of the file
printf '%s\n' "YESCRYPT_COST_FACTOR $var_password_yescrypt_cost_factor_login_defs" >> "/etc/login.defs"
# Clean up after ourselves.
rm "/etc/login.defs.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi