# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low


    if [ -e "/etc/security/pwhistory.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*enforce_for_root/Id" "/etc/security/pwhistory.conf"
else
    touch "/etc/security/pwhistory.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/security/pwhistory.conf"

cp "/etc/security/pwhistory.conf" "/etc/security/pwhistory.conf.bak"
# Insert at the end of the file
printf '%s\n' "enforce_for_root" >> "/etc/security/pwhistory.conf"
# Clean up after ourselves.
rm "/etc/security/pwhistory.conf.bak"