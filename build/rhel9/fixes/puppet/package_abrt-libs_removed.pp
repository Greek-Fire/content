# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_abrt-libs

class remove_abrt-libs {
  package { 'abrt-libs':
    ensure => 'purged',
  }
}