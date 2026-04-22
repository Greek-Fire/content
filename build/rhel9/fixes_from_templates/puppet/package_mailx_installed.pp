# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_mailx

class install_mailx {
  package { 'mailx':
    ensure => 'installed',
  }
}