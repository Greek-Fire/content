# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_nftables

class install_nftables {
  package { 'nftables':
    ensure => 'installed',
  }
}