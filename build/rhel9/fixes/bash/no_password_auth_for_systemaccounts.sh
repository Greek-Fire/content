# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = medium
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

readarray -t systemaccounts < <(awk -F: \
  '($3 < 1000 && $3 != root && $3 != halt && $3 != sync && $3 != shutdown \
  && $3 != nfsnobody) { print $1 }' /etc/passwd)

for systemaccount in "${systemaccounts[@]}"; do
    usermod -L "$systemaccount"
done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi