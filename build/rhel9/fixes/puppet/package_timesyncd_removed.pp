# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_systemd-timesyncd

class remove_systemd-timesyncd {
  package { 'systemd-timesyncd':
    ensure => 'purged',
  }
}