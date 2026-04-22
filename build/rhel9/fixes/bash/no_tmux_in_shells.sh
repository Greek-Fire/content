# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

if grep -q 'tmux\s*$' /etc/shells ; then
	sed -i '/tmux\s*$/d' /etc/shells
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi