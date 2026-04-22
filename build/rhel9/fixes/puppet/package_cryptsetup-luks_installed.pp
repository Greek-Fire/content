# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_cryptsetup

class install_cryptsetup {
  package { 'cryptsetup':
    ensure => 'installed',
  }
}