# platform = Red Hat Virtualization 4,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && rpm --quiet -q rsyslog; then

RSYSLOG_CONF='/etc/rsyslog.conf'
RSYSLOG_D_FOLDER='/etc/rsyslog.d'
RSYSLOG_D_CONF='/etc/rsyslog.d/encrypt.conf'
test -f $RSYSLOG_CONF || touch $RSYSLOG_CONF
mkdir -p $RSYSLOG_D_FOLDER
# remove all multilined cron.* entries
sed -i '/^[[:space:]]*cron\.\*.*action(/,/)/d' $RSYSLOG_CONF
find $RSYSLOG_D_FOLDER -type f -name "*.conf" -exec sed -i '/^[[:space:]]*cron\.\*.*action(/,/)/d' {} +
# remove all legacy format and one line cron.* entries
sed -i '/^\s*\*\.\*\s+/var/log/cron\s*$/d' $RSYSLOG_CONF
find $RSYSLOG_D_FOLDER -type f -name "*.conf" -exec sed -i '/^\s*\*\.\*\s+/var/log/cron\s*$/d' {} +
sed -i '/^[[:space:]]*cron\.\*/d' $RSYSLOG_CONF
find $RSYSLOG_D_FOLDER -type f -name "*.conf" -exec sed -i '/^[[:space:]]*cron\.\*/d' {} +

echo "cron.*	/var/log/cron" >> $RSYSLOG_D_CONF

if ! { rpm --quiet -q kernel rpm-ostree bootc && ! rpm --quiet -q openshift-kubelet && { [ -f "/run/.containerenv" ] || [ -f "/.containerenv" ]; }; } ; then
    systemctl restart rsyslog.service
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi