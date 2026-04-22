# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low


    if [[ -f  /etc/at.deny ]]; then
        rm /etc/at.deny
    fi
