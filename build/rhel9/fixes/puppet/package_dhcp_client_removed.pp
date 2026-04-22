# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_dhcp-client

class remove_dhcp-client {
  package { 'dhcp-client':
    ensure => 'purged',
  }
}