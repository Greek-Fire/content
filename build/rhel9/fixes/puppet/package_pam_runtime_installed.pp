# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_libpam-runtime

class install_libpam-runtime {
  package { 'libpam-runtime':
    ensure => 'installed',
  }
}