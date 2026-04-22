# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_nfs-common

class remove_nfs-common {
  package { 'nfs-common':
    ensure => 'purged',
  }
}