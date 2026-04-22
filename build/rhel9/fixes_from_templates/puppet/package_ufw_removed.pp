# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_ufw

class remove_ufw {
  package { 'ufw':
    ensure => 'purged',
  }
}
