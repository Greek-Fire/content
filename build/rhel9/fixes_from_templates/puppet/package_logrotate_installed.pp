# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_logrotate

class install_logrotate {
  package { 'logrotate':
    ensure => 'installed',
  }
}