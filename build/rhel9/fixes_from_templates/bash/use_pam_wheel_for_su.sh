# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low

declare -a VALUES=()
declare -a VALUE_NAMES=()
declare -a ARGS=()
declare -a NEW_ARGS=()
declare -a DEL_ARGS=()




VALUES+=("")
VALUE_NAMES+=("")
ARGS+=("use_uid")
NEW_ARGS+=("use_uid")


for idx in "${!VALUES[@]}"
do
    if [ -e "/etc/pam.d/su" ] ; then
        valueRegex="${VALUES[$idx]}" defaultValue="${VALUES[$idx]}"
        # non-empty values need to be preceded by an equals sign
        [ -n "${valueRegex}" ] && valueRegex="=${valueRegex}"
        # add an equals sign to non-empty values
        [ -n "${defaultValue}" ] && defaultValue="=${defaultValue}"

        # fix the value for 'option' if one exists but does not match 'valueRegex'
        if grep -q -P "^\\s*auth\\s+required\\s+pam_wheel.so(\\s.+)?\\s+${VALUE_NAMES[$idx]}(?"'!'"${valueRegex}(\\s|\$))" < "/etc/pam.d/su" ; then
            sed --follow-symlinks -i -E -e "s/^(\\s*auth\\s+required\\s+pam_wheel.so(\\s.+)?\\s)${VALUE_NAMES[$idx]}=[^[:space:]]*/\\1${VALUE_NAMES[$idx]}${defaultValue}/" "/etc/pam.d/su"

        # add 'option=default' if option is not set
        elif grep -q -E "^\\s*auth\\s+required\\s+pam_wheel.so" < "/etc/pam.d/su" &&
                grep    -E "^\\s*auth\\s+required\\s+pam_wheel.so" < "/etc/pam.d/su" | grep -q -E -v "\\s${VALUE_NAMES[$idx]}(=|\\s|\$)" ; then

            sed --follow-symlinks -i -E -e "s/^(\\s*auth\\s+required\\s+pam_wheel.so[^\\n]*)/\\1 ${VALUE_NAMES[$idx]}${defaultValue}/" "/etc/pam.d/su"
        # add a new entry if none exists
        elif ! grep -q -P "^\\s*auth\\s+required\\s+pam_wheel.so(\\s.+)?\\s+${VALUE_NAMES[$idx]}${valueRegex}(\\s|\$)" < "/etc/pam.d/su" ; then
            echo "auth required pam_wheel.so ${VALUE_NAMES[$idx]}${defaultValue}" >> "/etc/pam.d/su"
        fi
    else
        echo "/etc/pam.d/su doesn't exist" >&2
    fi
done

for idx in "${!ARGS[@]}"
do
    if ! grep -q -P "^\s*auth\s+required\s+pam_wheel.so.*\s+${ARGS[$idx]}\s*$" /etc/pam.d/su ; then
        sed --follow-symlinks -i -E -e "s/^\\s*auth\\s+required\\s+pam_wheel.so.*\$/& ${NEW_ARGS[$idx]}/" /etc/pam.d/su
        if [ -n "${DEL_ARGS[$idx]}" ]; then
            sed --follow-symlinks -i -E -e "s/\s+${DEL_ARGS[$idx]}\S+\s+/ /g" /etc/pam.d/su
        fi
    fi
done