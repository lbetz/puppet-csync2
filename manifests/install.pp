# @summary
#   This class handles the insatll of csync2.
# 
# # @api private
#
class csync2::install {

  $package_name   = $::csync2::globals::package_name
  $config_file    = $::csync2::globals::config_file
  $manage_package = $::csync2::manage_package

  if $manage_package {
    package { $package_name:
      ensure => installed,
    }
  }

  concat { $config_file:
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    warn   => true,
  }
}
