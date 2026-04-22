# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_nginx

class remove_nginx {
  package { 'nginx':
    ensure => 'purged',
  }
}