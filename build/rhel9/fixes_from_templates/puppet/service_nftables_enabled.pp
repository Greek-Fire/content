# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include enable_nftables

class enable_nftables {
  service {'nftables':
    enable => true,
    ensure => 'running',
  }
}