# platform = multi_platform_all
# reboot = false
# strategy = disable
# complexity = low
# disruption = low

include remove_libreport-plugin-rhtsupport

class remove_libreport-plugin-rhtsupport {
  package { 'libreport-plugin-rhtsupport':
    ensure => 'purged',
  }
}
