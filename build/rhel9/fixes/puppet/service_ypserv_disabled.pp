# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include disable_ypserv

class disable_ypserv {
  service {'ypserv':
    enable => false,
    ensure => 'stopped',
  }
}