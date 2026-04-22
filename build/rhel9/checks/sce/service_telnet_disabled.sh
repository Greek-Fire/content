#!/bin/bash
if [[ $(systemctl is-enabled telnet.socket) == "masked" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
