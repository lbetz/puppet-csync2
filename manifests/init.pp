# @summary Manages cluster software Csync2
#
# @example
#   include csync2
#
class csync2(
  Stdlib::Absolutepath      $config_file,
  Stdlib::Absolutepath      $csync2_bin,
  Stdlib::Absolutepath      $ssl_cert_file,
  Stdlib::Absolutepath      $ssl_key_file,
  Integer                   $port,
  Stdlib::Ensure::Service   $ensure   = 'running',
  Boolean                   $enable   = true,
  Optional[String]          $ssl_cert = undef,
  Optional[String]          $ssl_key  = undef,
) {

  Class['csync2::install']
    -> Class['csync2::config']
    -> Class['csync2::service']

  contain csync2::install
  contain csync2::config
  contain csync2::service

}
