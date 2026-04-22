# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q bash; then

for file in /root/.bashrc /root/.profile; do
    if [ -f "$file" ]; then
        sed -i -E -e "s/^([^#]*\bumask)[[:space:]]+[[:digit:]]+/\1 0027/g" "$file"
    fi
done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi