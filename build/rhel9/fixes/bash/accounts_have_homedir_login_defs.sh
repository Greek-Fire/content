# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if ( ( rpm --quiet -q shadow-utils && rpm --quiet -q kernel-core ) ); then

if [ -e "/etc/login.defs" ] ; then
    
    LC_ALL=C sed -i "/^\s*CREATE_HOME\s\+/Id" "/etc/login.defs"
else
    touch "/etc/login.defs"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/login.defs"

cp "/etc/login.defs" "/etc/login.defs.bak"
# Insert before the line matching the regex '^\s*CREATE_HOME'.
line_number="$(LC_ALL=C grep -n "^\s*CREATE_HOME" "/etc/login.defs.bak" | LC_ALL=C sed 's/:.*//g')"
if [ -z "$line_number" ]; then
    # There was no match of '^\s*CREATE_HOME', insert at
    # the end of the file.
    printf '%s\n' "CREATE_HOME yes" >> "/etc/login.defs"
else
    head -n "$(( line_number - 1 ))" "/etc/login.defs.bak" > "/etc/login.defs"
    printf '%s\n' "CREATE_HOME yes" >> "/etc/login.defs"
    tail -n "+$(( line_number ))" "/etc/login.defs.bak" >> "/etc/login.defs"
fi
# Clean up after ourselves.
rm "/etc/login.defs.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi