# platform = multi_platform_all
# reboot = false
# complexity = low
# strategy = configure
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

if ! rpm -q --quiet "firewalld" ; then
    dnf install -y "firewalld"
fi

if test "$(stat -c %d:%i /)" != "$(stat -c %d:%i /proc/1/root/.)" || { rpm --quiet -q kernel rpm-ostree bootc && ! rpm --quiet -q openshift-kubelet && { [ -f "/run/.containerenv" ] || [ -f "/.containerenv" ]; }; }; then
    firewall-offline-cmd --zone=trusted --add-interface=lo
elif systemctl is-active firewalld; then
    firewall-cmd --permanent --zone=trusted --add-interface=lo
    firewall-cmd --reload
else
    echo "
    firewalld service is not active. Remediation aborted!
    This remediation could not be applied because it depends on firewalld service running.
    The service is not started by this remediation in order to prevent connection issues."
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi