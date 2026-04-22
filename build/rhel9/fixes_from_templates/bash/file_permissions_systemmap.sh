# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low




find -P /boot/ -maxdepth 1 -perm /u+xs,g+xwrs,o+xwrt  -type f -regextype posix-extended -regex '^.*System\.map.*$' -exec chmod u-xs,g-xwrs,o-xwrt {} \;
