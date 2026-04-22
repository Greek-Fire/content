# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q chrony; }; then

var_multiple_time_servers='(bash-populate var_multiple_time_servers)'


config_file="/etc/chrony.conf"

if ! grep -q '^[[:space:]]*\(server\|pool\)[[:space:]]\+[[:graph:]]\+' "$config_file" ; then
  if ! grep -q '#[[:space:]]*server' "$config_file" ; then
    for server in $(echo "$var_multiple_time_servers" | tr ',' '\n') ; do
      printf '\nserver %s' "$server" >> "$config_file"
    done
  else
    sed -i 's/#[ \t]*server/server/g' "$config_file"
  fi
  if [[ -s "$config_file" ]] && [[ -n "$(tail -c 1 -- "$config_file" || true)" ]]; then
      LC_ALL=C sed -i --follow-symlinks '$a'\\ "$config_file"
  fi
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi