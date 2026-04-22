# platform = multi_platform_all

var_ssh_confirm_text='(bash-populate var_ssh_confirm_text)'


# Multiple regexes transform the banner regex into a usable banner
# 0 - Remove anchors around the banner text
var_ssh_confirm_text=$(echo "$var_ssh_confirm_text" | sed 's/^\^\(.*\)\$$/\1/g')
# 1 - Add spaces ' '. (Transforms regex for "space or newline" into a " ")
var_ssh_confirm_text=$(echo "$var_ssh_confirm_text" | sed 's/\[\\s\\n\]+/ /g')
# 2 - Adds newlines. (Transforms "(?:\[\n\]+|(?:\n)+)" into "\n")
var_ssh_confirm_text=$(echo "$var_ssh_confirm_text" | sed 's/(?:\[\\n\]+|(?:\\\\n)+)/\n/g')
# 3 - Remove any leftover backslash. (From any parenthesis in the banner, for example).
var_ssh_confirm_text=$(echo "$var_ssh_confirm_text" | sed 's/\\//g')
formatted=$(echo "$var_ssh_confirm_text")

OLD_UMASK=$(umask)
umask u=rw,go=r

cat <<EOF >/etc/profile.d/ssh_confirm.sh
$formatted
EOF

umask $OLD_UMASK