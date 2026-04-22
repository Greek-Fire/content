# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q pam; }; then

declare -a VALUES=()
declare -a VALUE_NAMES=()
declare -a ARGS=()
declare -a NEW_ARGS=()
declare -a DEL_ARGS=()




VALUES+=("")
VALUE_NAMES+=("")
ARGS+=("file")
NEW_ARGS+=("")
DEL_ARGS+=("file=")

for idx in "${!VALUES[@]}"
do
    if [ -e "/etc/pam.d/login" ] ; then
        valueRegex="${VALUES[$idx]}" defaultValue="${VALUES[$idx]}"
        # non-empty values need to be preceded by an equals sign
        [ -n "${valueRegex}" ] && valueRegex="=${valueRegex}"
        # add an equals sign to non-empty values
        [ -n "${defaultValue}" ] && defaultValue="=${defaultValue}"

        # fix the value for 'option' if one exists but does not match 'valueRegex'
        if grep -q -P "^\\s*auth\\s+required\\s+pam_tally2.so(\\s.+)?\\s+${VALUE_NAMES[$idx]}(?"'!'"${valueRegex}(\\s|\$))" < "/etc/pam.d/login" ; then
            sed --follow-symlinks -i -E -e "s/^(\\s*auth\\s+required\\s+pam_tally2.so(\\s.+)?\\s)${VALUE_NAMES[$idx]}=[^[:space:]]*/\\1${VALUE_NAMES[$idx]}${defaultValue}/" "/etc/pam.d/login"

        # add 'option=default' if option is not set
        elif grep -q -E "^\\s*auth\\s+required\\s+pam_tally2.so" < "/etc/pam.d/login" &&
                grep    -E "^\\s*auth\\s+required\\s+pam_tally2.so" < "/etc/pam.d/login" | grep -q -E -v "\\s${VALUE_NAMES[$idx]}(=|\\s|\$)" ; then

            sed --follow-symlinks -i -E -e "s/^(\\s*auth\\s+required\\s+pam_tally2.so[^\\n]*)/\\1 ${VALUE_NAMES[$idx]}${defaultValue}/" "/etc/pam.d/login"
        # add a new entry if none exists
        elif ! grep -q -P "^\\s*auth\\s+required\\s+pam_tally2.so(\\s.+)?\\s+${VALUE_NAMES[$idx]}${valueRegex}(\\s|\$)" < "/etc/pam.d/login" ; then
            echo "auth required pam_tally2.so ${VALUE_NAMES[$idx]}${defaultValue}" >> "/etc/pam.d/login"
        fi
    else
        echo "/etc/pam.d/login doesn't exist" >&2
    fi
done

for idx in "${!ARGS[@]}"
do
    if ! grep -q -P "^\s*auth\s+required\s+pam_tally2.so.*\s+${ARGS[$idx]}\s*$" /etc/pam.d/login ; then
        sed --follow-symlinks -i -E -e "s/^\\s*auth\\s+required\\s+pam_tally2.so.*\$/& ${NEW_ARGS[$idx]}/" /etc/pam.d/login
        if [ -n "${DEL_ARGS[$idx]}" ]; then
            sed --follow-symlinks -i -E -e "s/\s+${DEL_ARGS[$idx]}\S+\s+/ /g" /etc/pam.d/login
        fi
    fi
done

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi