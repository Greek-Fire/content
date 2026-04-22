# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low




find -P /lib/  -perm /g+w,o+w  -type f -regextype posix-extended -regex '^.*\.so.*$' -exec chmod g-w,o-w {} \;

find -P /lib64/  -perm /g+w,o+w  -type f -regextype posix-extended -regex '^.*\.so.*$' -exec chmod g-w,o-w {} \;

find -P /usr/lib/  -perm /g+w,o+w  -type f -regextype posix-extended -regex '^.*\.so.*$' -exec chmod g-w,o-w {} \;

find -P /usr/lib64/  -perm /g+w,o+w  -type f -regextype posix-extended -regex '^.*\.so.*$' -exec chmod g-w,o-w {} \;
