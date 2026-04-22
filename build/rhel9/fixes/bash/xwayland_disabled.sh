# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q gdm; then

found=false

# set value in all files if they contain section or key
for f in $(echo -n "/etc/gdm/custom.conf"); do
    if [ ! -e "$f" ]; then
        continue
    fi

    # find key in section and change value
    if grep -qzosP "(?m)^[[:space:]]*\[daemon\]([^\n\[]*\n+)+?[[:space:]]*WaylandEnable" "$f"; then
        if ! grep -qzosP "(?m)^[[:space:]]*WaylandEnable[[:space:]]*=[[:space:]]*false" "$f"; then

            sed -i "/^[[:space:]]*WaylandEnable/s/\([[:blank:]]*=[[:blank:]]*\).*/\1false/" "$f"

        fi

        found=true

    # find section and add key = value to it
    elif grep -qs "^[[:space:]]*\[daemon\]" "$f"; then

            sed -i "/^[[:space:]]*\[daemon\]/a WaylandEnable=false" "$f"

            found=true
    fi
done

# if section not in any file, append section with key = value to FIRST file in files parameter
if ! $found ; then
    file=$(echo "/etc/gdm/custom.conf" | cut -f1 -d ' ')
    mkdir -p "$(dirname "$file")"

    echo -e "[daemon]\nWaylandEnable=false" >> "$file"

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi