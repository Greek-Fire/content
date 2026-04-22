# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include disable_dnsmasq

class disable_dnsmasq {
  service {'dnsmasq':
    enable => false,
    ensure => 'stopped',
  }
}