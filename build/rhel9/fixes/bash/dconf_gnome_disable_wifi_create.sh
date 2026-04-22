# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q gdm; then

# Check for setting in any of the DConf db directories
# If files contain ibus or distro, ignore them.
# The assignment assumes that individual filenames don't contain :
readarray -t SETTINGSFILES < <(grep -r "\\[org/gnome/nm-applet\\]" "/etc/dconf/db/" \
                                | grep -v 'distro\|ibus\|local.d' | cut -d":" -f1)
DCONFFILE="/etc/dconf/db/local.d/00-security-settings"
DBDIR="/etc/dconf/db/local.d"

mkdir -p "${DBDIR}"

# Comment out the configurations in databases different from the target one
if [ "${#SETTINGSFILES[@]}" -ne 0 ]
then
    if grep -q "^\\s*disable-wifi-create\\s*=" "${SETTINGSFILES[@]}"
    then
        
        sed -Ei "s/(^\s*)disable-wifi-create(\s*=)/#\1disable-wifi-create\2/g" "${SETTINGSFILES[@]}"
    fi
fi

[ ! -z "${DCONFFILE}" ] && echo "" >> "${DCONFFILE}"
if ! grep -q "\\[org/gnome/nm-applet\\]" "${DCONFFILE}"
then
    printf '%s\n' "[org/gnome/nm-applet]" >> ${DCONFFILE}
fi

escaped_value="$(sed -e 's/\\/\\\\/g' <<< "true")"
if grep -q "^\\s*disable-wifi-create\\s*=" "${DCONFFILE}"
then
        sed -i "s/\\s*disable-wifi-create\\s*=\\s*.*/disable-wifi-create=${escaped_value}/g" "${DCONFFILE}"
    else
        sed -i "\\|\\[org/gnome/nm-applet\\]|a\\disable-wifi-create=${escaped_value}" "${DCONFFILE}"
fi
dconf update
# Check for setting in any of the DConf db directories
LOCKFILES=$(grep -r "^/org/gnome/nm-applet/disable-wifi-create$" "/etc/dconf/db/" \
            | grep -v 'distro\|ibus\|local.d' | grep ":" | cut -d":" -f1)
LOCKSFOLDER="/etc/dconf/db/local.d/locks"

mkdir -p "${LOCKSFOLDER}"

# Comment out the configurations in databases different from the target one
if [[ ! -z "${LOCKFILES}" ]]
then
    sed -i -E "s|^/org/gnome/nm-applet/disable-wifi-create$|#&|" "${LOCKFILES[@]}"
fi

if ! grep -qr "^/org/gnome/nm-applet/disable-wifi-create$" /etc/dconf/db/local.d/
then
    echo "/org/gnome/nm-applet/disable-wifi-create" >> "/etc/dconf/db/local.d/locks/00-security-settings-lock"
fi
dconf update

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi