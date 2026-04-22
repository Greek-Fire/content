# platform = multi_platform_all
# reboot = false
# strategy = configure
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if ( rpm --quiet -q grub2-common && rpm --quiet -q kernel-core ) && { ( ! ( [ -f /.dockerenv ] || [ -f /run/.containerenv ] ) ); }; then

chmod u-xs,g-xwrs,o-xwrt /boot/grub2/grub.cfg

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi