#!/bin/bash
if [[ $(systemctl is-enabled rsyslog.service) == "enabled" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
