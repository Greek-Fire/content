# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_python3-abrt-addon

class remove_python3-abrt-addon {
  package { 'python3-abrt-addon':
    ensure => 'purged',
  }
}
