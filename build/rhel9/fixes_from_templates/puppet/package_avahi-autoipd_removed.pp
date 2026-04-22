# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_avahi-autoipd

class remove_avahi-autoipd {
  package { 'avahi-autoipd':
    ensure => 'purged',
  }
}
