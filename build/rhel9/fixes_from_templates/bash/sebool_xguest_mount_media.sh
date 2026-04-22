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

    var_xguest_mount_media='(bash-populate var_xguest_mount_media)'

    /usr/sbin/setsebool -P xguest_mount_media $var_xguest_mount_media
