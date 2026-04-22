# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include disable_nginx

class disable_nginx {
  service {'nginx':
    enable => false,
    ensure => 'stopped',
  }
}