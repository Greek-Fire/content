#!/bin/bash
if [[ $(systemctl is-enabled dhcpd6.service) == "masked" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
