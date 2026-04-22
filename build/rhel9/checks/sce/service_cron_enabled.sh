#!/bin/bash
if [[ $(systemctl is-enabled crond.service) == "enabled" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
