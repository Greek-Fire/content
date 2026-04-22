#!/bin/bash
if [[ $(systemctl is-enabled firewalld.service) == "enabled" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
