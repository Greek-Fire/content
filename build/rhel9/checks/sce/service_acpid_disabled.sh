#!/bin/bash
if [[ $(systemctl is-enabled acpid.service) == "masked" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
