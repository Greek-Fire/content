# platform = multi_platform_almalinux,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_rhv,SUSE Linux Enterprise 15,SUSE Linux Enterprise 16
# reboot = false
# strategy = enable
# complexity = low
# disruption = low


if ! rpm -q --quiet "python3-libsemanage" ; then
    dnf install -y "python3-libsemanage"
fi


# Workaround for https://github.com/OpenSCAP/openscap/issues/2242: Use full
# path to setsebool command to avoid the issue with the command not being
# found.

    var_authlogin_nsswitch_use_ldap='(bash-populate var_authlogin_nsswitch_use_ldap)'

    /usr/sbin/setsebool -P authlogin_nsswitch_use_ldap $var_authlogin_nsswitch_use_ldap
