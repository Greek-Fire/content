# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_gnome-software

class install_gnome-software {
  package { 'gnome-software':
    ensure => 'installed',
  }
}