# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include disable_nftables

class disable_nftables {
  service {'nftables':
    enable => false,
    ensure => 'stopped',
  }
}