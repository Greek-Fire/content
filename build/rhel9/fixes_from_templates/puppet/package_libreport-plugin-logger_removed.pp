# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_libreport-plugin-logger

class remove_libreport-plugin-logger {
  package { 'libreport-plugin-logger':
    ensure => 'purged',
  }
}
