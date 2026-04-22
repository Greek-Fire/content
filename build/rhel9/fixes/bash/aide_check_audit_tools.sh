# platform = multi_platform_ol,multi_platform_rhel,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu,multi_platform_almalinux,multi_platform_debian,multi_platform_fedora
# reboot = false
# strategy = restrict
# complexity = low
# disruption = low
# Remediation is applicable only in certain platforms
if rpm --quiet -q kernel-core; then

if ! rpm -q --quiet "aide" ; then
    dnf install -y "aide"
fi










if grep -i -E '^.*(/usr)?/sbin/auditctl.*$' /etc/aide.conf; then
sed -i -r "s#.*(/usr)?/sbin/auditctl.*#/usr/sbin/auditctl p+i+n+u+g+s+b+acl+xattrs+sha512#" /etc/aide.conf
else
echo "/usr/sbin/auditctl p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide.conf
fi

if grep -i -E '^.*(/usr)?/sbin/auditd.*$' /etc/aide.conf; then
sed -i -r "s#.*(/usr)?/sbin/auditd.*#/usr/sbin/auditd p+i+n+u+g+s+b+acl+xattrs+sha512#" /etc/aide.conf
else
echo "/usr/sbin/auditd p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide.conf
fi

if grep -i -E '^.*(/usr)?/sbin/ausearch.*$' /etc/aide.conf; then
sed -i -r "s#.*(/usr)?/sbin/ausearch.*#/usr/sbin/ausearch p+i+n+u+g+s+b+acl+xattrs+sha512#" /etc/aide.conf
else
echo "/usr/sbin/ausearch p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide.conf
fi

if grep -i -E '^.*(/usr)?/sbin/aureport.*$' /etc/aide.conf; then
sed -i -r "s#.*(/usr)?/sbin/aureport.*#/usr/sbin/aureport p+i+n+u+g+s+b+acl+xattrs+sha512#" /etc/aide.conf
else
echo "/usr/sbin/aureport p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide.conf
fi

if grep -i -E '^.*(/usr)?/sbin/autrace.*$' /etc/aide.conf; then
sed -i -r "s#.*(/usr)?/sbin/autrace.*#/usr/sbin/autrace p+i+n+u+g+s+b+acl+xattrs+sha512#" /etc/aide.conf
else
echo "/usr/sbin/autrace p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide.conf
fi

if grep -i -E '^.*(/usr)?/sbin/augenrules.*$' /etc/aide.conf; then
sed -i -r "s#.*(/usr)?/sbin/augenrules.*#/usr/sbin/augenrules p+i+n+u+g+s+b+acl+xattrs+sha512#" /etc/aide.conf
else
echo "/usr/sbin/augenrules p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide.conf
fi

if grep -i -E '^.*(/usr)?/sbin/rsyslogd.*$' /etc/aide.conf; then
sed -i -r "s#.*(/usr)?/sbin/rsyslogd.*#/usr/sbin/rsyslogd p+i+n+u+g+s+b+acl+xattrs+sha512#" /etc/aide.conf
else
echo "/usr/sbin/rsyslogd p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide.conf
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi