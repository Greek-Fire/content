# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_inetutils-telnet

class remove_inetutils-telnet {
  package { 'inetutils-telnet':
    ensure => 'purged',
  }
}
