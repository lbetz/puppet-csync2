# @summary Manages cluster software Csync2.
#
# @example Configures an installed csync2 and also uses a preinstalled certivicate and private key.
#   include csync2
#
# @example To install a package with non default name. But you've to handle a repository yourself.
#   class { 'csync2':
#     package_name   => 'my-csync2',
#     manage_package => true,
#   }
#
# @example The management of certivivate and private key.
#   class { 'csync2':
#     ssl_cert => '-----BEGIN CERTIFICATE----- ...',
#     ssl_key  => '----BEGIN RSA PRIVATE KEY----- ...',
#   }
#
# @param [String] package_name
#   Package name to manage.
#
# @param [String] service_name
#   Name of the service to manage for Csync2.
#
# @param [Stdlib::Absolutepath] config_file
#   Path to the configuration file.
#
# @param [Stdlib::Absolutepath] csync2_bin
#   Path to the Cysnc2 binary.
#
# @param [Stdlib::Absolutepath] ssl_cert_path
#   Path to the fiile includes the certificate.
#
# @param [Stdlib::Absolutepath] ssl_key_path
#   Path to the file includes the private key.
#
# @param [Stdlib::Port::Unprivileged] port
#   Port ion Csync2 listens.
#
# @param [Stdlib::Ensure::Service] ensure
#   Whether the Csync2 service should be running or is stopped.
#
# @param [Boolean] enable
#   Whether to enable the Csync2 service at boot. 
#
# @param [Boolean] manage_package
#   Whether to install a Csync2 package.
#
# @param [Optional[Stdlib::Base64]] ssl_cert
#   The certificate to use for TLS connections. It will be stored into the file specified in ssl_cert_path.
#   If is set, you've also to set parameter ssl_key. Leaving both unset, you must manage the content of
#   ssl_cert_path and ssl_key_path yourself.
#
# @param [Optional[Stdlib::Base64]] ssl_key
#   The private key to use for TLS connections. It will be stored into the file specified in ssl_key_path.
#   If is set, you've also to set parameter ssl_cert. Leaving both unset, you must manage the content of
#   ssl_cert_path and ssl_key_path yourself.
#
class csync2(
  String                       $package_name,
  String                       $service_name,
  Stdlib::Absolutepath         $config_file,
  Stdlib::Absolutepath         $csync2_bin,
  Stdlib::Absolutepath         $ssl_cert_path,
  Stdlib::Absolutepath         $ssl_key_path,
  Stdlib::Port::Unprivileged   $port,
  Stdlib::Ensure::Service      $ensure         = 'running',
  Boolean                      $enable         = true,
  Boolean                      $manage_package = false,
  Optional[Stdlib::Base64]     $ssl_cert       = undef,
  Optional[Stdlib::Base64]     $ssl_key        = undef,
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
