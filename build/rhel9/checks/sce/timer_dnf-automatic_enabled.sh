#!/bin/bash
if [[ $(systemctl is-enabled dnf-automatic.timer) == "enabled" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
