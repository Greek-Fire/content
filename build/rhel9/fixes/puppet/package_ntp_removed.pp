# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_ntp

class remove_ntp {
  package { 'ntp':
    ensure => 'purged',
  }
}