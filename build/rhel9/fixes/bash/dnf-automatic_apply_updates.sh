# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if ( ( ! ( { rpm --quiet -q kernel-core ;} && { rpm --quiet -q rpm-ostree ;} && { rpm --quiet -q bootc ;} && { ! rpm --quiet -q openshift-kubelet ;} && ([ -f /run/ostree-booted ] || [ -L /ostree ]) ) && ! ( [ -f /.dockerenv ] || [ -f /run/.containerenv ] ) ) ); then

found=false

# set value in all files if they contain section or key
for f in $(echo -n "/etc/dnf/automatic.conf"); do
    if [ ! -e "$f" ]; then
        continue
    fi

    # find key in section and change value
    if grep -qzosP "(?m)^[[:space:]]*\[commands\]([^\n\[]*\n+)+?[[:space:]]*apply_updates" "$f"; then
        if ! grep -qzosP "(?m)^[[:space:]]*apply_updates[[:space:]]*=[[:space:]]*yes" "$f"; then

            sed -i "/^[[:space:]]*apply_updates/s/\([[:blank:]]*=[[:blank:]]*\).*/\1yes/" "$f"

        fi

        found=true

    # find section and add key = value to it
    elif grep -qs "^[[:space:]]*\[commands\]" "$f"; then

            sed -i "/^[[:space:]]*\[commands\]/a apply_updates=yes" "$f"

            found=true
    fi
done

# if section not in any file, append section with key = value to FIRST file in files parameter
if ! $found ; then
    file=$(echo "/etc/dnf/automatic.conf" | cut -f1 -d ' ')
    mkdir -p "$(dirname "$file")"

    echo -e "[commands]\napply_updates=yes" >> "$file"

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi