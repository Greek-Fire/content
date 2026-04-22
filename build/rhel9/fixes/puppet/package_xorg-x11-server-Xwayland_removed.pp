# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_xorg-x11-server-Xwayland

class remove_xorg-x11-server-Xwayland {
  package { 'xorg-x11-server-Xwayland':
    ensure => 'purged',
  }
}