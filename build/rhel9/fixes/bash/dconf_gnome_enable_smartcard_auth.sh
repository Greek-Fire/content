# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q gdm; then

# Check for setting in any of the DConf db directories
# If files contain ibus or distro, ignore them.
# The assignment assumes that individual filenames don't contain :
readarray -t SETTINGSFILES < <(grep -r "\\[org/gnome/login-screen\\]" "/etc/dconf/db/" \
                                | grep -v 'distro\|ibus\|distro.d' | cut -d":" -f1)
DCONFFILE="/etc/dconf/db/distro.d/00-security-settings"
DBDIR="/etc/dconf/db/distro.d"

mkdir -p "${DBDIR}"

# Comment out the configurations in databases different from the target one
if [ "${#SETTINGSFILES[@]}" -ne 0 ]
then
    if grep -q "^\\s*enable-smartcard-authentication\\s*=" "${SETTINGSFILES[@]}"
    then
        
        sed -Ei "s/(^\s*)enable-smartcard-authentication(\s*=)/#\1enable-smartcard-authentication\2/g" "${SETTINGSFILES[@]}"
    fi
fi

[ ! -z "${DCONFFILE}" ] && echo "" >> "${DCONFFILE}"
if ! grep -q "\\[org/gnome/login-screen\\]" "${DCONFFILE}"
then
    printf '%s\n' "[org/gnome/login-screen]" >> ${DCONFFILE}
fi

escaped_value="$(sed -e 's/\\/\\\\/g' <<< "true")"
if grep -q "^\\s*enable-smartcard-authentication\\s*=" "${DCONFFILE}"
then
        sed -i "s/\\s*enable-smartcard-authentication\\s*=\\s*.*/enable-smartcard-authentication=${escaped_value}/g" "${DCONFFILE}"
    else
        sed -i "\\|\\[org/gnome/login-screen\\]|a\\enable-smartcard-authentication=${escaped_value}" "${DCONFFILE}"
fi
dconf update
# Check for setting in any of the DConf db directories
LOCKFILES=$(grep -r "^/org/gnome/login-screen/enable-smartcard-authentication$" "/etc/dconf/db/" \
            | grep -v 'distro\|ibus\|distro.d' | grep ":" | cut -d":" -f1)
LOCKSFOLDER="/etc/dconf/db/distro.d/locks"

mkdir -p "${LOCKSFOLDER}"

# Comment out the configurations in databases different from the target one
if [[ ! -z "${LOCKFILES}" ]]
then
    sed -i -E "s|^/org/gnome/login-screen/enable-smartcard-authentication$|#&|" "${LOCKFILES[@]}"
fi

if ! grep -qr "^/org/gnome/login-screen/enable-smartcard-authentication$" /etc/dconf/db/distro.d/
then
    echo "/org/gnome/login-screen/enable-smartcard-authentication" >> "/etc/dconf/db/distro.d/locks/00-security-settings-lock"
fi
dconf update

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi