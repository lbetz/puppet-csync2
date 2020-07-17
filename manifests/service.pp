# @summary
#   This class handles the Csync2 service. By default the service will
#   start on boot and will be restarted if stopped.
#
# @api private
#
class csync2::service {

  $service_name = $::csync2::globals::service_name
  $ensure       = $::csync2::ensure
  $enable       = $::csync2::enable

  service { $service_name:
    ensure => $ensure,
    enable => $enable,
  }
}
