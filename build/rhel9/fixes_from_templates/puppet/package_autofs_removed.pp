# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_autofs

class remove_autofs {
  package { 'autofs':
    ensure => 'purged',
  }
}
