# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include disable_slapd

class disable_slapd {
  service {'slapd':
    enable => false,
    ensure => 'stopped',
  }
}