# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q gdm; then

# Check for setting in any of the DConf db directories
# If files contain ibus or distro, ignore them.
# The assignment assumes that individual filenames don't contain :
readarray -t SETTINGSFILES < <(grep -r "\\[org/gnome/system/location\\]" "/etc/dconf/db/" \
                                | grep -v 'distro\|ibus\|local.d' | cut -d":" -f1)
DCONFFILE="/etc/dconf/db/local.d/00-security-settings"
DBDIR="/etc/dconf/db/local.d"

mkdir -p "${DBDIR}"

# Comment out the configurations in databases different from the target one
if [ "${#SETTINGSFILES[@]}" -ne 0 ]
then
    if grep -q "^\\s*enabled\\s*=" "${SETTINGSFILES[@]}"
    then
        
        sed -Ei "s/(^\s*)enabled(\s*=)/#\1enabled\2/g" "${SETTINGSFILES[@]}"
    fi
fi

[ ! -z "${DCONFFILE}" ] && echo "" >> "${DCONFFILE}"
if ! grep -q "\\[org/gnome/system/location\\]" "${DCONFFILE}"
then
    printf '%s\n' "[org/gnome/system/location]" >> ${DCONFFILE}
fi

escaped_value="$(sed -e 's/\\/\\\\/g' <<< "false")"
if grep -q "^\\s*enabled\\s*=" "${DCONFFILE}"
then
        sed -i "s/\\s*enabled\\s*=\\s*.*/enabled=${escaped_value}/g" "${DCONFFILE}"
    else
        sed -i "\\|\\[org/gnome/system/location\\]|a\\enabled=${escaped_value}" "${DCONFFILE}"
fi
dconf update
# Check for setting in any of the DConf db directories
# If files contain ibus or distro, ignore them.
# The assignment assumes that individual filenames don't contain :
readarray -t SETTINGSFILES < <(grep -r "\\[org/gnome/clocks\\]" "/etc/dconf/db/" \
                                | grep -v 'distro\|ibus\|local.d' | cut -d":" -f1)
DCONFFILE="/etc/dconf/db/local.d/00-security-settings"
DBDIR="/etc/dconf/db/local.d"

mkdir -p "${DBDIR}"

# Comment out the configurations in databases different from the target one
if [ "${#SETTINGSFILES[@]}" -ne 0 ]
then
    if grep -q "^\\s*geolocation\\s*=" "${SETTINGSFILES[@]}"
    then
        
        sed -Ei "s/(^\s*)geolocation(\s*=)/#\1geolocation\2/g" "${SETTINGSFILES[@]}"
    fi
fi

[ ! -z "${DCONFFILE}" ] && echo "" >> "${DCONFFILE}"
if ! grep -q "\\[org/gnome/clocks\\]" "${DCONFFILE}"
then
    printf '%s\n' "[org/gnome/clocks]" >> ${DCONFFILE}
fi

escaped_value="$(sed -e 's/\\/\\\\/g' <<< "false")"
if grep -q "^\\s*geolocation\\s*=" "${DCONFFILE}"
then
        sed -i "s/\\s*geolocation\\s*=\\s*.*/geolocation=${escaped_value}/g" "${DCONFFILE}"
    else
        sed -i "\\|\\[org/gnome/clocks\\]|a\\geolocation=${escaped_value}" "${DCONFFILE}"
fi
dconf update
# Check for setting in any of the DConf db directories
LOCKFILES=$(grep -r "^/org/gnome/system/location/enabled$" "/etc/dconf/db/" \
            | grep -v 'distro\|ibus\|local.d' | grep ":" | cut -d":" -f1)
LOCKSFOLDER="/etc/dconf/db/local.d/locks"

mkdir -p "${LOCKSFOLDER}"

# Comment out the configurations in databases different from the target one
if [[ ! -z "${LOCKFILES}" ]]
then
    sed -i -E "s|^/org/gnome/system/location/enabled$|#&|" "${LOCKFILES[@]}"
fi

if ! grep -qr "^/org/gnome/system/location/enabled$" /etc/dconf/db/local.d/
then
    echo "/org/gnome/system/location/enabled" >> "/etc/dconf/db/local.d/locks/00-security-settings-lock"
fi
dconf update
# Check for setting in any of the DConf db directories
LOCKFILES=$(grep -r "^/org/gnome/clocks/geolocation$" "/etc/dconf/db/" \
            | grep -v 'distro\|ibus\|local.d' | grep ":" | cut -d":" -f1)
LOCKSFOLDER="/etc/dconf/db/local.d/locks"

mkdir -p "${LOCKSFOLDER}"

# Comment out the configurations in databases different from the target one
if [[ ! -z "${LOCKFILES}" ]]
then
    sed -i -E "s|^/org/gnome/clocks/geolocation$|#&|" "${LOCKFILES[@]}"
fi

if ! grep -qr "^/org/gnome/clocks/geolocation$" /etc/dconf/db/local.d/
then
    echo "/org/gnome/clocks/geolocation" >> "/etc/dconf/db/local.d/locks/00-security-settings-lock"
fi
dconf update

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi