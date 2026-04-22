# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

declare -a VALUES=()
declare -a VALUE_NAMES=()
declare -a ARGS=()
declare -a NEW_ARGS=()
declare -a DEL_ARGS=()






var_password_pam_ucredit='(bash-populate var_password_pam_ucredit)'

VALUES+=("$var_password_pam_ucredit")
VALUE_NAMES+=("ucredit")
ARGS+=("")
NEW_ARGS+=("")


for idx in "${!VALUES[@]}"
do
    if [ -e "/etc/pam.d/common-password" ] ; then
        valueRegex="${VALUES[$idx]}" defaultValue="${VALUES[$idx]}"
        # non-empty values need to be preceded by an equals sign
        [ -n "${valueRegex}" ] && valueRegex="=${valueRegex}"
        # add an equals sign to non-empty values
        [ -n "${defaultValue}" ] && defaultValue="=${defaultValue}"

        # fix the value for 'option' if one exists but does not match 'valueRegex'
        if grep -q -P "^\\s*password\\s+requisite\\s+pam_cracklib.so(\\s.+)?\\s+${VALUE_NAMES[$idx]}(?"'!'"${valueRegex}(\\s|\$))" < "/etc/pam.d/common-password" ; then
            sed --follow-symlinks -i -E -e "s/^(\\s*password\\s+requisite\\s+pam_cracklib.so(\\s.+)?\\s)${VALUE_NAMES[$idx]}=[^[:space:]]*/\\1${VALUE_NAMES[$idx]}${defaultValue}/" "/etc/pam.d/common-password"

        # add 'option=default' if option is not set
        elif grep -q -E "^\\s*password\\s+requisite\\s+pam_cracklib.so" < "/etc/pam.d/common-password" &&
                grep    -E "^\\s*password\\s+requisite\\s+pam_cracklib.so" < "/etc/pam.d/common-password" | grep -q -E -v "\\s${VALUE_NAMES[$idx]}(=|\\s|\$)" ; then

            sed --follow-symlinks -i -E -e "s/^(\\s*password\\s+requisite\\s+pam_cracklib.so[^\\n]*)/\\1 ${VALUE_NAMES[$idx]}${defaultValue}/" "/etc/pam.d/common-password"
        # add a new entry if none exists
        elif ! grep -q -P "^\\s*password\\s+requisite\\s+pam_cracklib.so(\\s.+)?\\s+${VALUE_NAMES[$idx]}${valueRegex}(\\s|\$)" < "/etc/pam.d/common-password" ; then
            echo "password requisite pam_cracklib.so ${VALUE_NAMES[$idx]}${defaultValue}" >> "/etc/pam.d/common-password"
        fi
    else
        echo "/etc/pam.d/common-password doesn't exist" >&2
    fi
done

for idx in "${!ARGS[@]}"
do
    if ! grep -q -P "^\s*password\s+requisite\s+pam_cracklib.so.*\s+${ARGS[$idx]}\s*$" /etc/pam.d/common-password ; then
        sed --follow-symlinks -i -E -e "s/^\\s*password\\s+requisite\\s+pam_cracklib.so.*\$/& ${NEW_ARGS[$idx]}/" /etc/pam.d/common-password
        if [ -n "${DEL_ARGS[$idx]}" ]; then
            sed --follow-symlinks -i -E -e "s/\s+${DEL_ARGS[$idx]}\S+\s+/ /g" /etc/pam.d/common-password
        fi
    fi
done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi