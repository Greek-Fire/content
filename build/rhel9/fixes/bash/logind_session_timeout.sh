# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { ( ( grep -qP "^ID=[\"']?rhel[\"']?$" "/etc/os-release" && { real="$(grep -P "^VERSION_ID=[\"']?[\w.]+[\"']?$" /etc/os-release | sed "s/^VERSION_ID=[\"']\?\([^\"']\+\)[\"']\?$/\1/")"; expected="8.7"; printf "%s\n%s" "$expected" "$real" | sort -VC; } && grep -qP "^ID=[\"']?rhel[\"']?$" "/etc/os-release" && { real="$(grep -P "^VERSION_ID=[\"']?[\w.]+[\"']?$" /etc/os-release | sed "s/^VERSION_ID=[\"']\?\([^\"']\+\)[\"']\?$/\1/")"; expected="9.0"; [[ "$real" != "$expected" ]]; } ) ) || ( grep -qP "^ID=[\"']?ol[\"']?$" "/etc/os-release" && { real="$(grep -P "^VERSION_ID=[\"']?[\w.]+[\"']?$" /etc/os-release | sed "s/^VERSION_ID=[\"']\?\([^\"']\+\)[\"']\?$/\1/")"; expected="8.7"; printf "%s\n%s" "$expected" "$real" | sort -VC; } ) || ( grep -qP "^ID=[\"']?sles[\"']?$" "/etc/os-release" && { real="$(grep -P "^VERSION_ID=[\"']?[\w.]+[\"']?$" /etc/os-release | sed "s/^VERSION_ID=[\"']\?\([^\"']\+\)[\"']\?$/\1/")"; expected="15"; printf "%s\n%s" "$expected" "$real" | sort -VC; } ); }; then

var_logind_session_timeout='(bash-populate var_logind_session_timeout)'


# Remove StopIdleSessionSec from main config

LC_ALL=C sed -i "/^\s*StopIdleSessionSec\s*=/Id" "/etc/systemd/logind.conf"


# create drop-in in the /etc/systemd/logind.conf.d/ directory

mkdir -p "/etc/systemd/logind.conf.d/"
# remove StopIdleSessionSec from drop-in files
LC_ALL=C sed -i "/^\s*StopIdleSessionSec\s*=/Id" "/etc/systemd/logind.conf.d"/*.conf




# Try find '[Login]' and 'StopIdleSessionSec' in '/etc/systemd/logind.conf.d/oscap-idle-sessions.conf', if it exists, set
# to '$var_logind_session_timeout', if it isn't here, add it, if '[Login]' doesn't exist, add it there
if grep -qzosP '[[:space:]]*\[Login]([^\n\[]*\n+)+?[[:space:]]*StopIdleSessionSec' '/etc/systemd/logind.conf.d/oscap-idle-sessions.conf'; then
    
    sed -i "s/StopIdleSessionSec[^(\n)]*/StopIdleSessionSec=$var_logind_session_timeout/" '/etc/systemd/logind.conf.d/oscap-idle-sessions.conf'
elif grep -qs '[[:space:]]*\[Login]' '/etc/systemd/logind.conf.d/oscap-idle-sessions.conf'; then
    sed -i "/[[:space:]]*\[Login]/a StopIdleSessionSec=$var_logind_session_timeout" '/etc/systemd/logind.conf.d/oscap-idle-sessions.conf'
else
    if test -d "/etc/systemd/logind.conf.d"; then
        printf '%s\n' '[Login]' "StopIdleSessionSec=$var_logind_session_timeout" >> '/etc/systemd/logind.conf.d/oscap-idle-sessions.conf'
    else
        echo "Config file directory '/etc/systemd/logind.conf.d' doesnt exist, not remediating, assuming non-applicability." >&2
    fi
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi