# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q logrotate; }; then

LOGROTATE_CONF_FILE='/etc/logrotate.conf'


if ! rpm -q --quiet "crontabs" ; then
    dnf install -y "crontabs"
fi
CRON_DAILY_LOGROTATE_FILE="/etc/cron.daily/logrotate"


# daily rotation is configured
grep -q "^daily$" $LOGROTATE_CONF_FILE|| sed -i '1i daily' "$LOGROTATE_CONF_FILE"

# remove any line configuring weekly, monthly or yearly rotation
sed -i '/^\s*\(weekly\|monthly\|yearly\).*$/d' $LOGROTATE_CONF_FILE


# configure cron.daily if not already
if ! grep -q "^[[:space:]]*/usr/sbin/logrotate[[:alnum:][:blank:][:punct:]]*$LOGROTATE_CONF_FILE$" $CRON_DAILY_LOGROTATE_FILE; then
	echo '#!/bin/sh' > $CRON_DAILY_LOGROTATE_FILE
	echo "/usr/sbin/logrotate $LOGROTATE_CONF_FILE" >> $CRON_DAILY_LOGROTATE_FILE
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi