# @summary Manages cluster software Csync2
#
# @example
#   include csync2
#
class csync2(
  String                    $package_name,
  Stdlib::Absolutepath      $config_file,
  Stdlib::Absolutepath      $csync2_bin,
  Stdlib::Absolutepath      $ssl_cert_file,
  Stdlib::Absolutepath      $ssl_key_file,
  Integer                   $port,
  Stdlib::Ensure::Service   $ensure         = 'running',
  Boolean                   $enable         = true,
  Boolean                   $manage_package = false,
  Optional[Stdlib::Base64]  $ssl_cert       = undef,
  Optional[Stdlib::Base64]  $ssl_key        = undef,
  Optional[String]          $service_name   = undef,
) {

  if $ssl_cert or $ssl_key {
    unless $ssl_cert and $ssl_key {
      fail('Both of ssl_cert and ssl_key must be set.')
    }
  }

  Class['csync2::install']
    -> Class['csync2::config']
    ~> Class['csync2::service']

  contain csync2::install
  contain csync2::config
  contain csync2::service

}
