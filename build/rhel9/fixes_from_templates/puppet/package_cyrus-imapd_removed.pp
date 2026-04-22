# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_cyrus-imapd

class remove_cyrus-imapd {
  package { 'cyrus-imapd':
    ensure => 'purged',
  }
}
