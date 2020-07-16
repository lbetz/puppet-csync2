# @summary
#   This class handles the host certificate and key.
# 
# # @api private
#
class csync2::install {

  $package_name   = $::csync2::package_name
  $manage_package = $::csync2::manage_package
  $ssl_cert_file  = $::csync2::ssl_cert_file
  $ssl_cert       = $::csync2::ssl_cert
  $ssl_key_file   = $::csync2::ssl_key_file
  $ssl_key        = $::csync2::ssl_key

  if $manage_package {
    package { $package_name:
      ensure => installed,
    }
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
