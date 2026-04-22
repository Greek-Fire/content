# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_pam

class install_pam {
  package { 'pam':
    ensure => 'installed',
  }
}