# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low




find -P /var/log/ -maxdepth 1 -perm /u+xs,g+xws,o+xwt  -type f -regextype posix-extended -regex '.*cloud-init.log([^\/]+)?$' -exec chmod u-xs,g-xws,o-xwt {} \;
