#!/bin/bash
if [[ $(systemctl is-enabled ip6tables.service) == "enabled" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
