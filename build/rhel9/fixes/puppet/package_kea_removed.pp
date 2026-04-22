# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_kea

class remove_kea {
  package { 'kea':
    ensure => 'purged',
  }
}