#!/bin/bash
if [[ $(systemctl is-enabled debug-shell.service) == "masked" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
