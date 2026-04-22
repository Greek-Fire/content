# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_389-ds-base

class remove_389-ds-base {
  package { '389-ds-base':
    ensure => 'purged',
  }
}