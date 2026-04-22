# platform = multi_platform_all
# reboot = true
# strategy = configure
# complexity = low
# disruption = low

expected_crypto_policy="DEFAULT:NO-SHA1"


expected_crypto_policy="${expected_crypto_policy}:NO-SSHCBC"
cat << 'EOF' > /etc/crypto-policies/policies/modules/NO-SSHCBC.pmod
cipher@SSH = -*-CBC
EOF

expected_crypto_policy="${expected_crypto_policy}:NO-SSHWEAKCIPHERS"
cat << 'EOF' > /etc/crypto-policies/policies/modules/NO-SSHWEAKCIPHERS.pmod
cipher@SSH = -3DES-CBC -AES-128-CBC -AES-192-CBC -AES-256-CBC -CHACHA20-POLY1305
EOF

expected_crypto_policy="${expected_crypto_policy}:NO-SSHWEAKMACS"
cat << 'EOF' > /etc/crypto-policies/policies/modules/NO-SSHWEAKMACS.pmod
mac@SSH = -HMAC-MD5* -UMAC-64* -UMAC-128*
EOF

expected_crypto_policy="${expected_crypto_policy}:NO-WEAKMAC"
cat << 'EOF' > /etc/crypto-policies/policies/modules/NO-WEAKMAC.pmod
mac = -*-128*
EOF

# this module is applicable only if rpm-sequoia scope is available in crypto-policies
if [[ -f /etc/crypto-policies/back-ends/rpm-sequoia.config ]] ; then
expected_crypto_policy="${expected_crypto_policy}:NO-RPMSHA1"
cat << 'EOF' > /etc/crypto-policies/policies/modules/NO-RPMSHA1.pmod
hash@rpm = -SHA1
EOF
fi


current_crypto_policy=$(update-crypto-policies --show)

if [[ "$current_crypto_policy" != "$expected_crypto_policy" ]] ; then
    update-crypto-policies --set "$expected_crypto_policy"
fi