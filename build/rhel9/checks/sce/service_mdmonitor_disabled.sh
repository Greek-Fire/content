#!/bin/bash
if [[ $(systemctl is-enabled mdmonitor.service) == "masked" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
