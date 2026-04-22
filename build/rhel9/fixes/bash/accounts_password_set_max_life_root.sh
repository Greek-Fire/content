# platform = multi_platform_debian,multi_platform_rhel,multi_platform_sle
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

var_accounts_maximum_age_root='(bash-populate var_accounts_maximum_age_root)'

chage -M $var_accounts_maximum_age_root root

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi