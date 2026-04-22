# platform = multi_platform_all
# reboot = true
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core && { rpm --quiet -q grub2-common; }; then

# Verify that Interactive Boot is Disabled in /etc/default/grub
CONFIRM_SPAWN_YES="systemd.confirm_spawn\(=\(1\|yes\|true\|on\)\|\b\)"
CONFIRM_SPAWN_NO="systemd.confirm_spawn=no"

if grep -q "\(GRUB_CMDLINE_LINUX\|GRUB_CMDLINE_LINUX_DEFAULT\)" /etc/default/grub
then
	sed -i "s/${CONFIRM_SPAWN_YES}/${CONFIRM_SPAWN_NO}/" /etc/default/grub
fi

# make sure GRUB_DISABLE_RECOVERY=true
if grep -q '^GRUB_DISABLE_RECOVERY=.*'  '/etc/default/grub' ; then
       # modify the GRUB command-line if an GRUB_DISABLE_RECOVERY= arg already exists
       sed -i 's/GRUB_DISABLE_RECOVERY=.*/GRUB_DISABLE_RECOVERY=true/' /etc/default/grub
else
       # no GRUB_DISABLE_RECOVERY=arg is present, append it to file
       echo "GRUB_DISABLE_RECOVERY=true"  >> '/etc/default/grub'
fi



# Remove 'systemd.confirm_spawn' kernel argument also from runtime settings
/sbin/grubby --update-kernel=ALL --remove-args="systemd.confirm_spawn"


#Regen grub.cfg handle updated GRUB_DISABLE_RECOVERY and confirm_spawn
grub2-mkconfig -o /boot/grub2/grub.cfg

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi