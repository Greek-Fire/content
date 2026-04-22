# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low


    if [ -e "/etc/pam_pkcs11/pam_pkcs11.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*use_mappers = pwent/Id" "/etc/pam_pkcs11/pam_pkcs11.conf"
else
    touch "/etc/pam_pkcs11/pam_pkcs11.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/pam_pkcs11/pam_pkcs11.conf"

cp "/etc/pam_pkcs11/pam_pkcs11.conf" "/etc/pam_pkcs11/pam_pkcs11.conf.bak"
# Insert at the end of the file
printf '%s\n' "use_mappers = pwent" >> "/etc/pam_pkcs11/pam_pkcs11.conf"
# Clean up after ourselves.
rm "/etc/pam_pkcs11/pam_pkcs11.conf.bak"