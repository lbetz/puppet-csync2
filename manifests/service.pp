# @summary
#   This class handles the Csync2 service. By default the service will
#   start on boot and will be restarted if stopped.
#
# @api private
#
class csync2::service {

  $ensure     = $::csync2::ensure
  $enable     = $::csync2::enable
  $csync2_bin = $::csync2::csync2_bin
  $port       = $::csync2::port

  systemd::unit_file { 'csync2@.service':
    content => template('csync2/service_unit.erb'),
  }
  
  systemd::unit_file { 'csync2.socket':
    content => template('csync2/service_socket.erb'),
  }
  
}
