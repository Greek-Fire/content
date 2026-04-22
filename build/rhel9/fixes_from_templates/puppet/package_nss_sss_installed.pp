# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_libnss-sss

class install_libnss-sss {
  package { 'libnss-sss':
    ensure => 'installed',
  }
}