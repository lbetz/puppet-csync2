# @summary Manages cluster software Csync2.
#   This class loads the default platform depending parameters by doing a hiera lookup.
#
# @api private
#
# @param [String] package_name
#   Package name to manage.
#
# @param [String] service_name
#   Name of the service to manage for Csync2.
#
# @param [Stdlib::Absolutepath] config_dir
#   Directory where Csync2 expected config, cert and key files.
#
# @param [Stdlib::Absolutepath] config_path
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
class csync2::globals(
  String                       $package_name,
  String                       $service_name,
  Stdlib::Absolutepath         $config_dir,
  Stdlib::Absolutepath         $config_path,
  Stdlib::Absolutepath         $csync2_bin,
  Stdlib::Absolutepath         $ssl_cert_path,
  Stdlib::Absolutepath         $ssl_key_path,
) {

  assert_private()

}
