# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if ( [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ] ); then

for interface in $(ip -o link show | cut -d ":" -f 2); do
    ip link set dev $interface multicast off promisc off
done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi