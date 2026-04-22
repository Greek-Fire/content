# platform = multi_platform_all
# reboot = true
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

cat << 'EOF' > /etc/crypto-policies/policies/modules/STIG.pmod
cipher@SSH=AES-256-GCM AES-256-CTR AES-128-GCM AES-128-CTR
mac@SSH=HMAC-SHA2-512 HMAC-SHA2-256
EOF

sudo update-crypto-policies --set FIPS:STIG

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi