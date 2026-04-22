# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if ( ( ! ( [ -f /.dockerenv ] || [ -f /run/.containerenv ] ) ) ); then

if ! rpm -q --quiet "NetworkManager" ; then
    dnf install -y "NetworkManager"
fi

if command -v nmcli >/dev/null 2>&1 && systemctl is-active NetworkManager >/dev/null 2>&1; then
    nmcli radio all off
fi

if command -v wicked >/dev/null 2>&1 && systemctl is-active wickedd >/dev/null 2>&1; then
  if [ -n "$(find /sys/class/net/*/ -type d -name wireless)" ]; then
    interfaces=$(find /sys/class/net/*/wireless -type d -name wireless | xargs -0 dirname | xargs basename)
    for iface in $interfaces; do
      wicked ifdown $iface
      sed -i 's/STARTMODE=.*/STARTMODE=off/' /etc/sysconfig/network/ifcfg-$iface
    done
  fi
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi