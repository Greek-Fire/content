# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low




find -H /etc/sysctl.d/ -maxdepth 0 -perm /u+s,g+ws,o+wt -type d -exec chmod u-s,g-ws,o-wt {} \;
