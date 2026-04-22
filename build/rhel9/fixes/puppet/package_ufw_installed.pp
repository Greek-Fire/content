# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_ufw

class install_ufw {
  package { 'ufw':
    ensure => 'installed',
  }
}