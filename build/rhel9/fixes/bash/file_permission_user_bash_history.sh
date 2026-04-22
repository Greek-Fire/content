# platform = multi_platform_sle,multi_platform_ubuntu,multi_platform_rhel
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q bash; then

readarray -t interactive_users < <(awk -F: '$3>=1000   {print $1}' /etc/passwd)
readarray -t interactive_users_home < <(awk -F: '$3>=1000   {print $6}' /etc/passwd)
readarray -t interactive_users_shell < <(awk -F: '$3>=1000   {print $7}' /etc/passwd)

USERS_IGNORED_REGEX='nobody|nfsnobody'

for (( i=0; i<"${#interactive_users[@]}"; i++ )); do
    if ! grep -qP "$USERS_IGNORED_REGEX" <<< "${interactive_users[$i]}" && \
        [ "${interactive_users_shell[$i]}" != "/sbin/nologin" ]; then

        chmod u-sx,go= "${interactive_users_home[$i]}/.bash_history"
    fi
done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi