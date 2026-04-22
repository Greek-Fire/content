# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_abrt-server-info-page

class remove_abrt-server-info-page {
  package { 'abrt-server-info-page':
    ensure => 'purged',
  }
}