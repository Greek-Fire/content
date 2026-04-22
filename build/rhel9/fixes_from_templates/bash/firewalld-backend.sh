# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
if [ -e "/etc/firewalld/firewalld.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*FirewallBackend\s*=\s*/d" "/etc/firewalld/firewalld.conf"
else
    touch "/etc/firewalld/firewalld.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/firewalld/firewalld.conf"

cp "/etc/firewalld/firewalld.conf" "/etc/firewalld/firewalld.conf.bak"
# Insert before the line matching the regex '^#\s*FirewallBackend'.
line_number="$(LC_ALL=C grep -n "^#\s*FirewallBackend" "/etc/firewalld/firewalld.conf.bak" | LC_ALL=C sed 's/:.*//g')"
if [ -z "$line_number" ]; then
    # There was no match of '^#\s*FirewallBackend', insert at
    # the end of the file.
    printf '%s\n' "FirewallBackend=nftables" >> "/etc/firewalld/firewalld.conf"
else
    head -n "$(( line_number - 1 ))" "/etc/firewalld/firewalld.conf.bak" > "/etc/firewalld/firewalld.conf"
    printf '%s\n' "FirewallBackend=nftables" >> "/etc/firewalld/firewalld.conf"
    tail -n "+$(( line_number ))" "/etc/firewalld/firewalld.conf.bak" >> "/etc/firewalld/firewalld.conf"
fi
# Clean up after ourselves.
rm "/etc/firewalld/firewalld.conf.bak"