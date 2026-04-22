# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_nfs-kernel-server

class remove_nfs-kernel-server {
  package { 'nfs-kernel-server':
    ensure => 'purged',
  }
}
