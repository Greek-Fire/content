#!/bin/bash
if [[ $(systemctl is-enabled sshd.service) == "enabled" ]] ; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
