# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_bind

class remove_bind {
  package { 'bind':
    ensure => 'purged',
  }
}

include remove_bind9.18

class remove_bind9.18 {
  package { 'bind9.18':
    ensure => 'purged',
  }
}