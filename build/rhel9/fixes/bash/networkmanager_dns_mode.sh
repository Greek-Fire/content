# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q NetworkManager; then

var_networkmanager_dns_mode='(bash-populate var_networkmanager_dns_mode)'

found=false

# set value in all files if they contain section or key
for f in $(echo -n "/etc/NetworkManager/conf.d/complianceascode_hardening.conf /etc/NetworkManager/conf.d/*.conf /etc/NetworkManager/NetworkManager.conf"); do
    if [ ! -e "$f" ]; then
        continue
    fi

    # find key in section and change value
    if grep -qzosP "(?m)^[[:space:]]*\[main\]([^\n\[]*\n+)+?[[:space:]]*dns" "$f"; then
        if ! grep -qzosP "(?m)^[[:space:]]*dns[[:space:]]*=[[:space:]]*$var_networkmanager_dns_mode" "$f"; then

            sed -i "/^[[:space:]]*dns/s/\([[:blank:]]*=[[:blank:]]*\).*/\1$var_networkmanager_dns_mode/" "$f"

        fi

        found=true

    # find section and add key = value to it
    elif grep -qs "^[[:space:]]*\[main\]" "$f"; then

            sed -i "/^[[:space:]]*\[main\]/a dns=$var_networkmanager_dns_mode" "$f"

            found=true
    fi
done

# if section not in any file, append section with key = value to FIRST file in files parameter
if ! $found ; then
    file=$(echo "/etc/NetworkManager/conf.d/complianceascode_hardening.conf /etc/NetworkManager/conf.d/*.conf /etc/NetworkManager/NetworkManager.conf" | cut -f1 -d ' ')
    mkdir -p "$(dirname "$file")"

    echo -e "[main]\ndns=$var_networkmanager_dns_mode" >> "$file"

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi