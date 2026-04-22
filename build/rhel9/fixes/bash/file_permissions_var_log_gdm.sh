# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low




find -P /var/log/gdm/  -perm /u+xs,g+xs,o+xwrt  -type f -regextype posix-extended -regex '.*' -exec chmod u-xs,g-xs,o-xwrt {} \;