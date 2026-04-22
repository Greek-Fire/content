# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_libdnf-plugin-subscription-manager

class install_libdnf-plugin-subscription-manager {
  package { 'libdnf-plugin-subscription-manager':
    ensure => 'installed',
  }
}