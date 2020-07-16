# @summary
#   This class exists to manage general configuration files needed by Csync2 to run.
#
# @api private
#
class csync2::config {

  $config_file    = $::csync2::config_file
  $ssl_cert_file  = $::csync2::ssl_cert_file
  $ssl_cert       = $::csync2::ssl_cert
  $ssl_key_file   = $::csync2::ssl_key_file
  $ssl_key        = $::csync2::ssl_key
  $csync2_bin     = $::csync2::csync2_bin
  $port           = $::csync2::port

  concat { $config_file:
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    warn   => true,
  }

  if $ssl_key and $ssl_cert {
    file {
      default:
        ensure => file,
        owner  => 'root',
        group  => 'root';
      $ssl_cert_file:
        content => $ssl_cert,
        mode    => '0644';
      $ssl_key_file:
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
