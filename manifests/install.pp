# @summary
#   This class handles the insatll of csync2.
# 
# # @api private
#
class csync2::install {

  $package_name   = $::csync2::package_name
  $manage_package = $::csync2::manage_package

  if $manage_package {
    package { $package_name:
      ensure => installed,
    }
  }
  
}
