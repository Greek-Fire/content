# platform = multi_platform_all
# reboot = false
# strategy = enable
# complexity = low
# disruption = low
include install_dracut-fips

class install_dracut-fips {
  package { 'dracut-fips':
    ensure => 'installed',
  }
}