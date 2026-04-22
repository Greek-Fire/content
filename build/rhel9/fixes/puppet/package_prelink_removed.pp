# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_prelink

class remove_prelink {
  package { 'prelink':
    ensure => 'purged',
  }
}