# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_audit-libs

class install_audit-libs {
  package { 'audit-libs':
    ensure => 'installed',
  }
}