# @summary
#   This class handles the host certificate and key.
# 
# # @api private
#
class csync2::install {

  $ssl_cert_file = $::csync2::ssl_cert_file
  $ssl_cert      = $::csync2::ssl_cert
  $ssl_key_file  = $::csync2::ssl_key_file
  $ssl_key       = $::csync2::ssl_key

  unless $ssl_cert and $ssl_key {
    fail('Both of ssl_cert and ssl_key must be set.')
  }

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
