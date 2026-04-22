# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q rootfiles; then

find "/etc/tmpfiles.d/" -name "*.conf" -print0 | xargs -0 sed -i  "/C[[:space:]]*\/root\/.bash_logout/d"
    find "/etc/tmpfiles.d/" -name "*.conf" -print0 | xargs -0 sed -i  "/C[[:space:]]*\/root\/.bash_profile/d"
    find "/etc/tmpfiles.d/" -name "*.conf" -print0 | xargs -0 sed -i  "/C[[:space:]]*\/root\/.bashrc/d"
    find "/etc/tmpfiles.d/" -name "*.conf" -print0 | xargs -0 sed -i  "/C[[:space:]]*\/root\/.cshrc/d"
    find "/etc/tmpfiles.d/" -name "*.conf" -print0 | xargs -0 sed -i  "/C[[:space:]]*\/root\/.tcshrc/d"


cat << 'EOF' > /etc/tmpfiles.d/rootfiles.conf
C /root/.bash_logout 600 root root - /usr/share/rootfiles/.bash_logout
C /root/.bash_profile 600 root root - /usr/share/rootfiles/.bash_profile
C /root/.bashrc 600 root root - /usr/share/rootfiles/.bashrc
C /root/.cshrc 600 root root - /usr/share/rootfiles/.cshrc
C /root/.tcshrc 600 root root - /usr/share/rootfiles/.tcshrc

EOF

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi