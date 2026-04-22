# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_authselect

class install_authselect {
  package { 'authselect':
    ensure => 'installed',
  }
}