# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_iptables-persistent

class install_iptables-persistent {
  package { 'iptables-persistent':
    ensure => 'installed',
  }
}