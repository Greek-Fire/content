# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_rpcbind

class remove_rpcbind {
  package { 'rpcbind':
    ensure => 'purged',
  }
}