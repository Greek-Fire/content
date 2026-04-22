# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_s-nail

class install_s-nail {
  package { 's-nail':
    ensure => 'installed',
  }
}