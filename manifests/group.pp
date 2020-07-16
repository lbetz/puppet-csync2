# @summary
#   Manages a Csync2 group.
#
# @example
#   csync2::group { 'newgroup': }
#
define csync2::group (
  Array[Stdlib::Host]        $hosts,
  String                     $key,
  Enum['present', 'absent']  $ensure   = 'present',
  String                     $group    = $title,
  Stdlib::Absolutepath       $key_path = "/etc/csync2.key_${group}",
  Boolean                    $ssl      = true,  
  Enum['none', 'younger']    $auto     = 'younger',
  Optional[Hash]             $blocks   = undef,
) {

  require ::csync2

  $config_file = $::csync2::config_file

  if $ensure == 'present' {
    concat::fragment { "csync2-group-${group}":
      target  => $config_file,
      content => template('csync2/group.erb'),
    }

    $key_path_ensure = 'file'
  } else {
    $key_path_ensure = 'absent'
  }

  file { $key_path:
    ensure  => $key_path_ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => "${key}\n",
  }

}
