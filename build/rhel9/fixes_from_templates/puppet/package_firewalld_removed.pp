# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_firewalld

class remove_firewalld {
  package { 'firewalld':
    ensure => 'purged',
  }
}
