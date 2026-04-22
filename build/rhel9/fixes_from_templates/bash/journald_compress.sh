# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low


found=false

# set value in all files if they contain section or key
for f in $(echo -n "/etc/systemd/journald.conf.d/complianceascode_hardening.conf /etc/systemd/journald.conf.d/*.conf /etc/systemd/journald.conf"); do
    if [ ! -e "$f" ]; then
        continue
    fi

    # find key in section and change value
    if grep -qzosP "(?m)^[[:space:]]*\[Journal\]([^\n\[]*\n+)+?[[:space:]]*Compress" "$f"; then
        if ! grep -qzosP "(?m)^[[:space:]]*Compress[[:space:]]*=[[:space:]]*yes" "$f"; then

            sed -i "/^[[:space:]]*Compress/s/\([[:blank:]]*=[[:blank:]]*\).*/\1yes/" "$f"

        fi

        found=true

    # find section and add key = value to it
    elif grep -qs "^[[:space:]]*\[Journal\]" "$f"; then

            sed -i "/^[[:space:]]*\[Journal\]/a Compress=yes" "$f"

            found=true
    fi
done

# if section not in any file, append section with key = value to FIRST file in files parameter
if ! $found ; then
    file=$(echo "/etc/systemd/journald.conf.d/complianceascode_hardening.conf /etc/systemd/journald.conf.d/*.conf /etc/systemd/journald.conf" | cut -f1 -d ' ')
    mkdir -p "$(dirname "$file")"

    echo -e "[Journal]\nCompress=yes" >> "$file"

fi
