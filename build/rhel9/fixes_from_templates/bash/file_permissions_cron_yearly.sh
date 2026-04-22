# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low




find -H /etc/cron.yearly/ -maxdepth 0 -perm /u+s,g+xwrs,o+xwrt -type d -exec chmod u-s,g-xwrs,o-xwrt {} \;
