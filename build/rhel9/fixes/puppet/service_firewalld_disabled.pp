# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include disable_firewalld

class disable_firewalld {
  service {'firewalld':
    enable => false,
    ensure => 'stopped',
  }
}