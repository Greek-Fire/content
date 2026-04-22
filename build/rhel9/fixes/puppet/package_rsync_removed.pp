# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_rsync-daemon

class remove_rsync-daemon {
  package { 'rsync-daemon':
    ensure => 'purged',
  }
}