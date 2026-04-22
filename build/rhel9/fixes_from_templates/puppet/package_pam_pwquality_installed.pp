# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_libpwquality

class install_libpwquality {
  package { 'libpwquality':
    ensure => 'installed',
  }
}