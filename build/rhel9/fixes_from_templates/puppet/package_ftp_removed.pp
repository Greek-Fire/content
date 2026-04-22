# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_ftp

class remove_ftp {
  package { 'ftp':
    ensure => 'purged',
  }
}
