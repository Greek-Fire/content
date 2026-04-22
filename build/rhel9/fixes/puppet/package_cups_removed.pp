# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_cups

class remove_cups {
  package { 'cups':
    ensure => 'purged',
  }
}