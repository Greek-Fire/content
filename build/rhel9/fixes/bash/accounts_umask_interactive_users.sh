# platform = multi_platform_rhel,multi_platform_ol,multi_platform_sle,multi_platform_rhv4,multi_platform_almalinux
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

while IFS= read -r dir; do
    while IFS= read -r -d '' file; do
        if [ "$(basename $file)" != ".bash_history" ]; then
            sed -i 's/^\(\s*umask\s*\)/#\1/g' "$file"
        fi
    done <   <(find $dir -maxdepth 1 -type f -name ".*" -print0)
done <   <(awk -F':' '{ if ($3 >= 1000 && $3 != 65534) print $6}' /etc/passwd)

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi