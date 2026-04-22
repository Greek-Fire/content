# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low




find -P /boot/grub2/ -maxdepth 1 -perm /u+xs,g+xwrs,o+xwrt  -type f -regextype posix-extended -regex '^.*$' -exec chmod u-xs,g-xwrs,o-xwrt {} \;
