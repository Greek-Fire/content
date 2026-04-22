# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_tnftp

class remove_tnftp {
  package { 'tnftp':
    ensure => 'purged',
  }
}