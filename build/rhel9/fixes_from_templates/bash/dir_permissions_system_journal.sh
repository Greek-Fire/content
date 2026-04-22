# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low




find -H /run/log/journal/  -perm /u+s,g+w,o+xwrt -type d -exec chmod u-s,g-w,o-xwrt {} \;

find -H /var/log/journal/  -perm /u+s,g+w,o+xwrt -type d -exec chmod u-s,g-w,o-xwrt {} \;
