#!/bin/bash
if [[ $(systemctl is-enabled rpcsvcgssd.service) == "masked" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
