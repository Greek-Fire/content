# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

found=false

# set value in all files if they contain section or key
for f in $(echo -n "/etc/systemd/system/rescue.service.d/10-oscap.conf /etc/systemd/system/rescue.service.d/*.conf"); do
    if [ ! -e "$f" ]; then
        continue
    fi

    # find key in section and change value
    if grep -qzosP "(?m)^[[:space:]]*\[Service\]([^\n\[]*\n+)+?[[:space:]]*ExecStart" "$f"; then
        if ! grep -qzosP "(?m)^[[:space:]]*ExecStart[[:space:]]*=[[:space:]]*\nExecStart=-/usr/lib/systemd/systemd-sulogin-shell rescue" "$f"; then

            sed -i "/^[[:space:]]*ExecStart/s/\([[:blank:]]*=[[:blank:]]*\).*/\1\nExecStart=-\/usr\/lib\/systemd\/systemd-sulogin-shell rescue/" "$f"

        fi

        found=true

    # find section and add key = value to it
    elif grep -qs "^[[:space:]]*\[Service\]" "$f"; then

            sed -i "/^[[:space:]]*\[Service\]/a ExecStart=\nExecStart=-\/usr\/lib\/systemd\/systemd-sulogin-shell rescue" "$f"

            found=true
    fi
done

# if section not in any file, append section with key = value to FIRST file in files parameter
if ! $found ; then
    file=$(echo "/etc/systemd/system/rescue.service.d/10-oscap.conf /etc/systemd/system/rescue.service.d/*.conf" | cut -f1 -d ' ')
    mkdir -p "$(dirname "$file")"

    echo -e "[Service]\nExecStart=\nExecStart=-/usr/lib/systemd/systemd-sulogin-shell rescue" >> "$file"

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi