# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include enable_syslog-ng

class enable_syslog-ng {
  service {'syslog-ng':
    enable => true,
    ensure => 'running',
  }
}