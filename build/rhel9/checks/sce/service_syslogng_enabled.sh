#!/bin/bash
if [[ $(systemctl is-enabled syslog-ng.service) == "enabled" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
