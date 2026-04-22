# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_iptables-nft

class install_iptables-nft {
  package { 'iptables-nft':
    ensure => 'installed',
  }
}