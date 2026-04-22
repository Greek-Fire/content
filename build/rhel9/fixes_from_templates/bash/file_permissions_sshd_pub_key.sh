# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low




find -P /etc/ssh/ -maxdepth 1 -perm /u+xs,g+xws,o+xwt  -type f -regextype posix-extended -regex '^.*\.pub$' -exec chmod u-xs,g-xws,o-xwt {} \;
