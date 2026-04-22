# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_tcpd

class remove_tcpd {
  package { 'tcpd':
    ensure => 'purged',
  }
}
