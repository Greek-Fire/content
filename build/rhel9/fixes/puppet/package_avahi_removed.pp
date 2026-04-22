# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_avahi

class remove_avahi {
  package { 'avahi':
    ensure => 'purged',
  }
}