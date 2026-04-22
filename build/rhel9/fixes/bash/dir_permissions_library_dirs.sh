# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low




find -H /lib/  -perm /g+w,o+w -type d -exec chmod g-w,o-w {} \;

find -H /lib64/  -perm /g+w,o+w -type d -exec chmod g-w,o-w {} \;

find -H /usr/lib/  -perm /g+w,o+w -type d -exec chmod g-w,o-w {} \;

find -H /usr/lib64/  -perm /g+w,o+w -type d -exec chmod g-w,o-w {} \;