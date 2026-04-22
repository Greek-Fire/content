# platform = Red Hat Virtualization 4,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_almalinux
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && rpm --quiet -q rsyslog; then

RSYSLOG_CONF='/etc/rsyslog.conf'
RSYSLOG_D_FOLDER='/etc/rsyslog.d'
RSYSLOG_D_CONF='/etc/rsyslog.d/encrypt.conf'
test -f $RSYSLOG_CONF || touch $RSYSLOG_CONF
mkdir -p $RSYSLOG_D_FOLDER
# remove legacy entries
sed -i '/^[[:space:]]*\$ActionSendStreamDriverAuthMode/d' $RSYSLOG_CONF
find $RSYSLOG_D_FOLDER -type f -name "*.conf" -exec sed -i '/^[[:space:]]*\$ActionSendStreamDriverAuthMode/d' {} +
# remove all multilined and onelined RainerScript entries
sed -i '/^[[:space:]]*action(/ { :a; N; /)/!ba; /StreamDriverAuthMode/d }' $RSYSLOG_CONF
find $RSYSLOG_D_FOLDER -type f -name "*.conf" -exec sed -i '/^[[:space:]]*action(/ { :a; N; /)/!ba; /StreamDriverAuthMode/d }' {} +

if [ -e "$RSYSLOG_D_CONF" ] ; then
    
    LC_ALL=C sed -i "/^\s*\$ActionSendStreamDriverAuthMode /Id" "$RSYSLOG_D_CONF"
else
    touch "$RSYSLOG_D_CONF"
fi
# make sure file has newline at the end
sed -i -e '$a\' "$RSYSLOG_D_CONF"

cp "$RSYSLOG_D_CONF" "$RSYSLOG_D_CONF.bak"
# Insert at the end of the file
printf '%s\n' "\$ActionSendStreamDriverAuthMode x509/name" >> "$RSYSLOG_D_CONF"
# Clean up after ourselves.
rm "$RSYSLOG_D_CONF.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi