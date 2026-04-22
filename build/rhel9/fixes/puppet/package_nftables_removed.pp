# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_nftables

class remove_nftables {
  package { 'nftables':
    ensure => 'purged',
  }
}