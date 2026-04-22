# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_dnsmasq

class remove_dnsmasq {
  package { 'dnsmasq':
    ensure => 'purged',
  }
}