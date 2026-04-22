# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low




find -P /var/log/ -maxdepth 1 -perm /u+xs,g+xs,o+xwt  -type f -regextype posix-extended -regex '.*lastlog(\.[^\/]+)?$' -exec chmod u-xs,g-xs,o-xwt {} \;
