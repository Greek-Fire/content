# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_unbound

class remove_unbound {
  package { 'unbound':
    ensure => 'purged',
  }
}