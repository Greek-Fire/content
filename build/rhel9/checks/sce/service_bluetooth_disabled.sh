#!/bin/bash
if [[ $(systemctl is-enabled bluetooth.service) == "masked" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
