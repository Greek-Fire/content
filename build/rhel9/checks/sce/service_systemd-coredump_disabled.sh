#!/bin/bash
if [[ $(systemctl is-enabled systemd-coredump.socket) == "masked" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
