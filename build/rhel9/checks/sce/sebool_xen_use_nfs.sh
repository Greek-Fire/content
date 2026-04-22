#!/usr/bin/env bash



function check_sebool_value()
{
    local seboolid="$1"
    local exp_value="$2"

    # Check if seinfo is available
    if command -v seinfo &> /dev/null; then
        if seinfo -xb "$seboolid" | grep -q "$seboolid[[:space:]]\+$exp_value;"; then
            return $XCCDF_RESULT_PASS
        else
            return $XCCDF_RESULT_FAIL
        fi
    else
        # getsebool returns either on or off and we have to translate the value first
        if [[ "$2" == "true" ]]; then
            exp_value="on"
        elif [[ "$2" == "false" ]]; then
            exp_value="off"
        fi

        if getsebool "$seboolid" | grep -q "$seboolid[[:space:]]-->[[:space:]]$exp_value"; then
            return $XCCDF_RESULT_PASS
        else
            return $XCCDF_RESULT_FAIL
        fi
    fi
}

expected_value="$XCCDF_VALUE_var_xen_use_nfs"

check_sebool_value xen_use_nfs "$expected_value"
exit $?
