# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include enable_ufw

class enable_ufw {
  service {'ufw':
    enable => true,
    ensure => 'running',
  }
}