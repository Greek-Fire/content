# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include enable_systemd-journal-upload

class enable_systemd-journal-upload {
  service {'systemd-journal-upload':
    enable => true,
    ensure => 'running',
  }
}