# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include disable_systemd-timesyncd

class disable_systemd-timesyncd {
  service {'systemd-timesyncd':
    enable => false,
    ensure => 'stopped',
  }
}