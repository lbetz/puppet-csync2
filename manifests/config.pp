# @summary
#   This class exists to manage general configuration files needed by Csync2 to run.
#
# @api private
#
class csync2::config {

  $config_file = $::csync2::config_file

  concat { $config_file:
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    warn   => true,
  }

}
