#!/usr/bin/env bash



FILES_NOT_MANAGED_BY_PACKAGES=("/etc/sysctl.conf" "/etc/sysctl.d/*.conf" "/usr/local/lib/sysctl.d/*.conf" "/run/sysctl.d/*.conf")

FILES_MANAGED_BY_PACKAGES=("/usr/lib/sysctl.d/*.conf")


function pass_if_set_correctly()
{
    local filelist="$1"
    local regex="$2"
    local expected_value="$3"
    local found=0
    for files in $filelist ; do
        [[ -e "$files" ]] || continue
        found_value=$(grep -P "$regex" $files | sed -E "s/$regex/\1/")
        if [[ -n "$found_value" ]] ; then
            if [[ "$found_value" == "$expected_value" ]] ; then
                found=1
            else
                return 1
            fi
        fi
    done
    if [[ $found == 1 ]] ; then
        return 0
    fi
    return 1
}

function pass_if_missing()
{
    local filelist="$1"
    local regex="$2"
    for files in $filelist ; do
        [[ -e "$files" ]] || continue
        if grep -P "$regex"  $files ; then
            return 1
        fi
    done
    return 0
}

function check_sysctl_configuration()
{
    local sysctlvar="$1"
    local expected_value="$2"

    regex="^\s*$sysctlvar\s*=\s*(.*)\s*"

    # kernel static parameter $sysctlvar set to $sysctlvar in sysctl files not managed by packages
    pass_if_set_correctly "${FILES_NOT_MANAGED_BY_PACKAGES[*]}" "$regex" "$expected_value"
    set_correctly_in_not_managed="$?"

    # kernel static parameter $sysctlvar missing in sysctl files not managed by packages
    pass_if_missing "${FILES_NOT_MANAGED_BY_PACKAGES[*]}" "$regex"
    missing_in_not_managed="$?"

    # kernel static parameter $sysctlvar set to $sysctlval in sysctl files managed by packages
    pass_if_set_correctly "${FILES_MANAGED_BY_PACKAGES[*]}" "$regex" "$expected_value"
    set_correctly_in_managed="$?"

    if [[ "$set_correctly_in_not_managed" == 0 || ( "$missing_in_not_managed" == 0 && "$set_correctly_in_managed" == 0 ) ]] ; then
        return 0
    fi
    return 1
}




expected_value="1"
check_sysctl_configuration "net.ipv4.conf.all.drop_gratuitous_arp" "$expected_value"
if [[ $? == 0 ]] ; then
    exit $XCCDF_RESULT_PASS
fi

exit $XCCDF_RESULT_FAIL
