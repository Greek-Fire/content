# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
cis_banner_text='(bash-populate cis_banner_text)'

echo "$cis_banner_text" > "/etc/motd"