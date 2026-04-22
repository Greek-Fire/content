# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_pcsc-lite-ccid

class install_pcsc-lite-ccid {
  package { 'pcsc-lite-ccid':
    ensure => 'installed',
  }
}