# @summary
#   This class exists to manage general configuration files needed by Csync2 to run.
#
# @api private
#
class csync2::config {

  $ssl_cert_path  = $::csync2::ssl_cert_path
  $ssl_cert       = $::csync2::ssl_cert
  $ssl_key_path   = $::csync2::ssl_key_path
  $ssl_key        = $::csync2::ssl_key
  $csync2_bin     = $::csync2::csync2_bin
  $port           = $::csync2::port

  if $ssl_key and $ssl_cert {
    file {
      default:
        ensure => file,
        owner  => 'root',
        group  => 'root';
      $ssl_cert_path:
        content => $ssl_cert,
        mode    => '0644';
      $ssl_key_path:
        content => $ssl_key,
        mode    => '0600';
    }
  }

  systemd::unit_file { 'csync2@.service':
    content => template('csync2/service_unit.erb'),
  }

  systemd::unit_file { 'csync2.socket':
    content => template('csync2/service_socket.erb'),
  }

}
