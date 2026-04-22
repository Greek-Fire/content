# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include disable_chronyd

class disable_chronyd {
  service {'chronyd':
    enable => false,
    ensure => 'stopped',
  }
}