# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_apparmor-utils

class install_apparmor-utils {
  package { 'apparmor-utils':
    ensure => 'installed',
  }
}