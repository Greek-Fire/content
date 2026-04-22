# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q nftables; then

var_nftables_family='(bash-populate var_nftables_family)'

var_nftables_table='(bash-populate var_nftables_table)'


if ! nft list table $var_nftables_family $var_nftables_table; then
  nft create table "$var_nftables_family" "$var_nftables_table"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi