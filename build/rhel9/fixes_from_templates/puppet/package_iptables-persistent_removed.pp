# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_iptables-persistent

class remove_iptables-persistent {
  package { 'iptables-persistent':
    ensure => 'purged',
  }
}
