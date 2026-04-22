# platform = multi_platform_rhel,multi_platform_fedora,multi_platform_ol,multi_platform_rhv,multi_platform_sle,multi_platform_almalinux
# Remediation is applicable only in certain platforms
if ! ( { rpm --quiet -q kernel-core ;} && { rpm --quiet -q rpm-ostree ;} && { rpm --quiet -q bootc ;} && { ! rpm --quiet -q openshift-kubelet ;} && ([ -f /run/ostree-booted ] || [ -L /ostree ]) ); then

# Find which files have incorrect hash (not in /etc, because of the system related config files) and then get files names
files_with_incorrect_hash="$(rpm -Va --noconfig | grep -E '^..5' | awk '{print $NF}' )"

if [ -n "$files_with_incorrect_hash" ]; then
    # From files names get package names and change newline to space, because rpm writes each package to new line
    packages_to_reinstall="$(rpm -qf $files_with_incorrect_hash | tr '\n' ' ')"

    
    dnf reinstall -y $packages_to_reinstall
    
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi