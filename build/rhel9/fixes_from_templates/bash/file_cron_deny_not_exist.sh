# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low


    if [[ -f  /etc/cron.deny ]]; then
        rm /etc/cron.deny
    fi
