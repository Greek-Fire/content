# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = medium
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

readarray -t systemaccounts < <(awk -F: '($3 < 1000 && $1 != "root" \
  && $7 != "\/sbin\/shutdown" && $7 != "\/sbin\/halt" && $7 != "\/bin\/sync") \
  { print $1 }' /etc/passwd)

for systemaccount in "${systemaccounts[@]}"; do
    usermod -s /sbin/nologin "$systemaccount"
done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi