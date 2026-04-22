#!/bin/bash
if [[ $(systemctl is-enabled named.service) == "masked" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
