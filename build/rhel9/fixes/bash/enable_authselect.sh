# platform = multi_platform_all
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

var_authselect_profile='(bash-populate var_authselect_profile)'


authselect current

if test "$?" -ne 0; then
    if { rpm --quiet -q kernel rpm-ostree bootc && ! rpm --quiet -q openshift-kubelet && { [ -f "/run/.containerenv" ] || [ -f "/.containerenv" ]; }; }; then
        authselect select --force "$var_authselect_profile"
    else
        authselect select "$var_authselect_profile"
    fi

    if test "$?" -ne 0; then
        if rpm --quiet --verify pam; then
            authselect select --force "$var_authselect_profile"
        else
	        echo "authselect is not used but files from the 'pam' package have been altered, so the authselect configuration won't be forced." >&2
        fi
    fi
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi