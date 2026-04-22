# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_iptables-services

class remove_iptables-services {
  package { 'iptables-services':
    ensure => 'purged',
  }
}