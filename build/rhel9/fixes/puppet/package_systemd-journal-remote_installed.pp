# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_systemd-journal-remote

class install_systemd-journal-remote {
  package { 'systemd-journal-remote':
    ensure => 'installed',
  }
}