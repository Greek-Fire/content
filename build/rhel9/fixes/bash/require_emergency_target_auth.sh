# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

service_dropin_cfg_dir="/etc/systemd/system/emergency.service.d"
service_dropin_file="${service_dropin_cfg_dir}/10-oscap.conf"


sulogin="/usr/lib/systemd/systemd-sulogin-shell emergency"


mkdir -p "${service_dropin_cfg_dir}"
echo "[Service]" >> "${service_dropin_file}"
echo "ExecStart=" >> "${service_dropin_file}"
echo "ExecStart=-$sulogin" >> "${service_dropin_file}"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi