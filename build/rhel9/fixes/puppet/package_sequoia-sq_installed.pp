# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_sequoia-sq

class install_sequoia-sq {
  package { 'sequoia-sq':
    ensure => 'installed',
  }
}