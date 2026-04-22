# platform = multi_platform_all

# Check for setting in any of the DConf db directories
# If files contain ibus or distro, ignore them.
# The assignment assumes that individual filenames don't contain :
readarray -t SETTINGSFILES < <(grep -r "\\[org/gnome/settings-daemon/peripherals/smartcard\\]" "/etc/dconf/db/" \
                                | grep -v 'distro\|ibus\|local.d' | cut -d":" -f1)
DCONFFILE="/etc/dconf/db/local.d/00-security-settings"
DBDIR="/etc/dconf/db/local.d"

mkdir -p "${DBDIR}"

# Comment out the configurations in databases different from the target one
if [ "${#SETTINGSFILES[@]}" -ne 0 ]
then
    if grep -q "^\\s*removal-action\\s*=" "${SETTINGSFILES[@]}"
    then
        
        sed -Ei "s/(^\s*)removal-action(\s*=)/#\1removal-action\2/g" "${SETTINGSFILES[@]}"
    fi
fi

[ ! -z "${DCONFFILE}" ] && echo "" >> "${DCONFFILE}"
if ! grep -q "\\[org/gnome/settings-daemon/peripherals/smartcard\\]" "${DCONFFILE}"
then
    printf '%s\n' "[org/gnome/settings-daemon/peripherals/smartcard]" >> ${DCONFFILE}
fi

escaped_value="$(sed -e 's/\\/\\\\/g' <<< "'lock-screen'")"
if grep -q "^\\s*removal-action\\s*=" "${DCONFFILE}"
then
        sed -i "s/\\s*removal-action\\s*=\\s*.*/removal-action=${escaped_value}/g" "${DCONFFILE}"
    else
        sed -i "\\|\\[org/gnome/settings-daemon/peripherals/smartcard\\]|a\\removal-action=${escaped_value}" "${DCONFFILE}"
fi
dconf update
# Check for setting in any of the DConf db directories
LOCKFILES=$(grep -r "^/org/gnome/settings-daemon/peripherals/smartcard/removal-action$" "/etc/dconf/db/" \
            | grep -v 'distro\|ibus\|local.d' | grep ":" | cut -d":" -f1)
LOCKSFOLDER="/etc/dconf/db/local.d/locks"

mkdir -p "${LOCKSFOLDER}"

# Comment out the configurations in databases different from the target one
if [[ ! -z "${LOCKFILES}" ]]
then
    sed -i -E "s|^/org/gnome/settings-daemon/peripherals/smartcard/removal-action$|#&|" "${LOCKFILES[@]}"
fi

if ! grep -qr "^/org/gnome/settings-daemon/peripherals/smartcard/removal-action$" /etc/dconf/db/local.d/
then
    echo "/org/gnome/settings-daemon/peripherals/smartcard/removal-action" >> "/etc/dconf/db/local.d/locks/00-security-settings-lock"
fi
dconf update