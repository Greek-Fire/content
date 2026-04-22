#!/bin/bash
if [[ $(systemctl is-enabled rsh.service) == "masked" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
