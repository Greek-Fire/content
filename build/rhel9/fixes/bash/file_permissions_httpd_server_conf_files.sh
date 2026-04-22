# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low




find -P /etc/httpd/conf/ -maxdepth 1 -perm /u+xs,g+xws,o+xwrt  -type f -regextype posix-extended -regex '^.*$' -exec chmod u-xs,g-xws,o-xwrt {} \;