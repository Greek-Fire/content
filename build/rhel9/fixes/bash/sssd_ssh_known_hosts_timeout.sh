# platform = Red Hat Virtualization 4,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if rpm --quiet -q sssd-common; then

var_sssd_ssh_known_hosts_timeout='(bash-populate var_sssd_ssh_known_hosts_timeout)'


# sssd configuration files must be created with 600 permissions if they don't exist
# otherwise the sssd module fails to start
OLD_UMASK=$(umask)
umask u=rw,go=

found=false

# set value in all files if they contain section or key
for f in $(echo -n "/etc/sssd/sssd.conf"); do
    if [ ! -e "$f" ]; then
        continue
    fi

    # find key in section and change value
    if grep -qzosP "(?m)^[[:space:]]*\[ssh\]([^\n\[]*\n+)+?[[:space:]]*ssh_known_hosts_timeout" "$f"; then
        if ! grep -qzosP "(?m)^[[:space:]]*ssh_known_hosts_timeout[[:space:]]*=[[:space:]]*$var_sssd_ssh_known_hosts_timeout" "$f"; then

            sed -i "/^[[:space:]]*ssh_known_hosts_timeout/s/\([[:blank:]]*=[[:blank:]]*\).*/\1$var_sssd_ssh_known_hosts_timeout/" "$f"

        fi

        found=true

    # find section and add key = value to it
    elif grep -qs "^[[:space:]]*\[ssh\]" "$f"; then

            sed -i "/^[[:space:]]*\[ssh\]/a ssh_known_hosts_timeout=$var_sssd_ssh_known_hosts_timeout" "$f"

            found=true
    fi
done

# if section not in any file, append section with key = value to FIRST file in files parameter
if ! $found ; then
    file=$(echo "/etc/sssd/sssd.conf" | cut -f1 -d ' ')
    mkdir -p "$(dirname "$file")"

    echo -e "[ssh]\nssh_known_hosts_timeout=$var_sssd_ssh_known_hosts_timeout" >> "$file"

fi

umask $OLD_UMASK

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi