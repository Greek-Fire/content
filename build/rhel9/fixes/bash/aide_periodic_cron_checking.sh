# platform = Red Hat Virtualization 4,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_sle,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

if ! rpm -q --quiet "aide" ; then
    dnf install -y "aide"
fi


if ! rpm -q --quiet "cronie" ; then
    dnf install -y "cronie"
fi



CRON_FILE="/etc/crontab"


if ! grep -q "/usr/sbin/aide --check" "${CRON_FILE}" ; then
    echo "05 4 * * * root /usr/sbin/aide --check" >> "${CRON_FILE}"
else
    sed -i '\!^.* --check.*$!d' "${CRON_FILE}"
    echo "05 4 * * * root /usr/sbin/aide --check" >> "${CRON_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi