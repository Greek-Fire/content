# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_iptables-services

class install_iptables-services {
  package { 'iptables-services':
    ensure => 'installed',
  }
}