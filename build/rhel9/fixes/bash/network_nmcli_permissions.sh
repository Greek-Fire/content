# platform = multi_platform_all
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q polkit; then

if ! rpm -q --quiet "polkit-pkla-compat" ; then
    dnf install -y "polkit-pkla-compat"
fi
printf "[Disable General User Access to NetworkManager]\nIdentity=default\nAction=org.freedesktop.NetworkManager.*\nResultAny=no\nResultInactive=no\nResultActive=auth_admin\n" > /etc/polkit-1/localauthority/20-org.d/10-nm-harden-access.pkla

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi