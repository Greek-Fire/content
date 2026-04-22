# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_libpam-modules

class install_libpam-modules {
  package { 'libpam-modules':
    ensure => 'installed',
  }
}