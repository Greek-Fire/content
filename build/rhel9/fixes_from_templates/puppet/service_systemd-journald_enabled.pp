# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include enable_systemd-journald

class enable_systemd-journald {
  service {'systemd-journald':
    enable => true,
    ensure => 'running',
  }
}