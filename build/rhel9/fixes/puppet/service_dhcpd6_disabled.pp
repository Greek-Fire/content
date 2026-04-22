# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include disable_dhcpd6

class disable_dhcpd6 {
  service {'dhcpd6':
    enable => false,
    ensure => 'stopped',
  }
}