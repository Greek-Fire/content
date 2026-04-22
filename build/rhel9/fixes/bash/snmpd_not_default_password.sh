# platform = debian 11,debian 10,multi_platform_fedora,Oracle Linux 7,Oracle Linux 8,multi_platform_rhel
# Remediation is applicable only in certain platforms
if rpm --quiet -q net-snmp; then

var_snmpd_ro_string='(bash-populate var_snmpd_ro_string)'
var_snmpd_rw_string='(bash-populate var_snmpd_rw_string)'


# remediate read-only community string
if grep -q 'public' /etc/snmp/snmpd.conf; then
    sed -i "s/public/$var_snmpd_ro_string/" /etc/snmp/snmpd.conf
fi

# remediate read-write community string
if grep -q 'private' /etc/snmp/snmpd.conf; then
    sed -i "s/private/$var_snmpd_rw_string/" /etc/snmp/snmpd.conf
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi