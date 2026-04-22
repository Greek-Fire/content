# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q sudo; }; then

if grep -x '^Defaults targetpw$' /etc/sudoers; then
    sed -i "/Defaults targetpw/d" /etc/sudoers \;
fi
if grep -x '^Defaults targetpw$' /etc/sudoers.d/*; then
    find /etc/sudoers.d/ -type f -exec sed -i "/Defaults targetpw/d" {} \;
fi
if grep -x '^Defaults rootpw$' /etc/sudoers; then
    sed -i "/Defaults rootpw/d" /etc/sudoers \;
fi
if grep -x '^Defaults rootpw$' /etc/sudoers.d/*; then
    find /etc/sudoers.d/ -type f -exec sed -i "/Defaults rootpw/d" {} \;
fi
if grep -x '^Defaults runaspw$' /etc/sudoers; then
    sed -i "/Defaults runaspw/d" /etc/sudoers \;
fi
if grep -x '^Defaults runaspw$' /etc/sudoers.d/*; then
    find /etc/sudoers.d/ -type f -exec sed -i "/Defaults runaspw/d" {} \;
fi

if [ -e "/etc/sudoers" ] ; then
    
    LC_ALL=C sed -i "/Defaults !targetpw/d" "/etc/sudoers"
else
    touch "/etc/sudoers"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/sudoers"

cp "/etc/sudoers" "/etc/sudoers.bak"
# Insert at the end of the file
printf '%s\n' "Defaults !targetpw" >> "/etc/sudoers"
# Clean up after ourselves.
rm "/etc/sudoers.bak"
if [ -e "/etc/sudoers" ] ; then
    
    LC_ALL=C sed -i "/Defaults !rootpw/d" "/etc/sudoers"
else
    touch "/etc/sudoers"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/sudoers"

cp "/etc/sudoers" "/etc/sudoers.bak"
# Insert at the end of the file
printf '%s\n' "Defaults !rootpw" >> "/etc/sudoers"
# Clean up after ourselves.
rm "/etc/sudoers.bak"
if [ -e "/etc/sudoers" ] ; then
    
    LC_ALL=C sed -i "/Defaults !runaspw/d" "/etc/sudoers"
else
    touch "/etc/sudoers"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/sudoers"

cp "/etc/sudoers" "/etc/sudoers.bak"
# Insert at the end of the file
printf '%s\n' "Defaults !runaspw" >> "/etc/sudoers"
# Clean up after ourselves.
rm "/etc/sudoers.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi