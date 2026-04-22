# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_syslog-ng

class install_syslog-ng {
  package { 'syslog-ng':
    ensure => 'installed',
  }
}