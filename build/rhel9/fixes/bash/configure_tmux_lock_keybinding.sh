# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q tmux; }; then

tmux_conf="/etc/tmux.conf"

if ! grep -qP '^\s*bind\s+\w\s+lock-session' "$tmux_conf" ; then
    echo "bind X lock-session" >> "$tmux_conf"
fi
chmod 0644 "$tmux_conf"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi