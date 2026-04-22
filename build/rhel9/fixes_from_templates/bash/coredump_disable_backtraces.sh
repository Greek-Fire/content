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
    if grep -qzosP "(?m)^[[:space:]]*\[Coredump\]([^\n\[]*\n+)+?[[:space:]]*ProcessSizeMax" "$f"; then
        if ! grep -qzosP "(?m)^[[:space:]]*ProcessSizeMax[[:space:]]*=[[:space:]]*0" "$f"; then

            sed -i "/^[[:space:]]*ProcessSizeMax/s/\([[:blank:]]*=[[:blank:]]*\).*/\10/" "$f"

        fi

        found=true

    # find section and add key = value to it
    elif grep -qs "^[[:space:]]*\[Coredump\]" "$f"; then

            sed -i "/^[[:space:]]*\[Coredump\]/a ProcessSizeMax=0" "$f"

            found=true
    fi
done

# if section not in any file, append section with key = value to FIRST file in files parameter
if ! $found ; then
    file=$(echo "/etc/systemd/coredump.conf.d/complianceascode_hardening.conf /etc/systemd/coredump.conf.d/*.conf /etc/systemd/coredump.conf" | cut -f1 -d ' ')
    mkdir -p "$(dirname "$file")"

    echo -e "[Coredump]\nProcessSizeMax=0" >> "$file"

fi
