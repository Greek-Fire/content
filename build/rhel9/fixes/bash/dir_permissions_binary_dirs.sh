# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low




find -H /bin/  -perm /u+s,g+ws,o+wt -type d -exec chmod u-s,g-ws,o-wt {} \;

find -H /sbin/  -perm /u+s,g+ws,o+wt -type d -exec chmod u-s,g-ws,o-wt {} \;

find -H /usr/bin/  -perm /u+s,g+ws,o+wt -type d -exec chmod u-s,g-ws,o-wt {} \;

find -H /usr/sbin/  -perm /u+s,g+ws,o+wt -type d -exec chmod u-s,g-ws,o-wt {} \;

find -H /usr/local/bin/  -perm /u+s,g+ws,o+wt -type d -exec chmod u-s,g-ws,o-wt {} \;

find -H /usr/local/sbin/  -perm /u+s,g+ws,o+wt -type d -exec chmod u-s,g-ws,o-wt {} \;