# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low


found=false

# set value in all files if they contain section or key
for f in $(echo -n "/etc/systemd/coredump.conf.d/complianceascode_hardening.conf /etc/systemd/coredump.conf.d/*.conf /etc/systemd/coredump.conf"); do
    if [ ! -e "$f" ]; then
        continue
    fi

    # find key in section and change value
    if grep -qzosP "(?m)^[[:space:]]*\[Coredump\]([^\n\[]*\n+)+?[[:space:]]*Storage" "$f"; then
        if ! grep -qzosP "(?m)^[[:space:]]*Storage[[:space:]]*=[[:space:]]*none" "$f"; then

            sed -i "/^[[:space:]]*Storage/s/\([[:blank:]]*=[[:blank:]]*\).*/\1none/" "$f"

        fi

        found=true

    # find section and add key = value to it
    elif grep -qs "^[[:space:]]*\[Coredump\]" "$f"; then

            sed -i "/^[[:space:]]*\[Coredump\]/a Storage=none" "$f"

            found=true
    fi
done

# if section not in any file, append section with key = value to FIRST file in files parameter
if ! $found ; then
    file=$(echo "/etc/systemd/coredump.conf.d/complianceascode_hardening.conf /etc/systemd/coredump.conf.d/*.conf /etc/systemd/coredump.conf" | cut -f1 -d ' ')
    mkdir -p "$(dirname "$file")"

    echo -e "[Coredump]\nStorage=none" >> "$file"

fi
