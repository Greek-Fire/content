# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_libpam-sss

class install_libpam-sss {
  package { 'libpam-sss':
    ensure => 'installed',
  }
}