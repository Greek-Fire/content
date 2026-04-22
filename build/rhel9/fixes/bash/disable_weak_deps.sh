# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q dnf; then

found=false

# set value in all files if they contain section or key
for f in $(echo -n "/etc/dnf/dnf.conf"); do
    if [ ! -e "$f" ]; then
        continue
    fi

    # find key in section and change value
    if grep -qzosP "(?m)^[[:space:]]*\[main\]([^\n\[]*\n+)+?[[:space:]]*install_weak_deps" "$f"; then
        if ! grep -qzosP "(?m)^[[:space:]]*install_weak_deps[[:space:]]*=[[:space:]]*0" "$f"; then

            sed -i "/^[[:space:]]*install_weak_deps/s/\([[:blank:]]*=[[:blank:]]*\).*/\10/" "$f"

        fi

        found=true

    # find section and add key = value to it
    elif grep -qs "^[[:space:]]*\[main\]" "$f"; then

            sed -i "/^[[:space:]]*\[main\]/a install_weak_deps=0" "$f"

            found=true
    fi
done

# if section not in any file, append section with key = value to FIRST file in files parameter
if ! $found ; then
    file=$(echo "/etc/dnf/dnf.conf" | cut -f1 -d ' ')
    mkdir -p "$(dirname "$file")"

    echo -e "[main]\ninstall_weak_deps=0" >> "$file"

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi