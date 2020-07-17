# @summary
#   Manages a Csync2 group.
#
# @example A simple example to sync the csync2 config itself.
#   csync2::group { 'cluster':
#     hosts  => ['node1.example.org', 'node2.example.org'],
#     blocks => [
#       {
#         'includes' => [ '/etc/csync2.cfg' ],
#       },
#     ],
#     key    => 'supersecret',
#   }
#
# @example A more complex example with two blocks and actions.
#   csync2::group { 'monitoring':
#     hosts  => ['node1.example.org', 'node2.example.org'],
#     blocks => [
#       {
#         'includes' => [ '/etc/icinga2/features-available', '/etc/icinga2/features-enabled' ],
#         'actions'  => [
#           {
#             'pattern' => [ '/etc/icinga2/features-enabled/*' ],
#             'exec'    => [ 'systemctl reload icinga2' ],
#             'logfile' => '/var/log/csync2_action.log',
#             'do'      => 'do-local',
#           },
#         ],
#       },
#       {
#         'includes' => [ '/etc/icingaweb2' ],
#         'excludes' => [ '/etc/icingaweb2/modules/director', '/etc/icingaweb2/enabledModules/director' ],
#       },
#     ],
#     key    => 'supersecret-2',
#   }
#
# @param [Array[Stdlib::Host]] hosts
#   All involved hosts of the group.
#
# @param [String] key
#   The symmetric key to authenticate hosts to each other.
#
# @param [Enum['present', 'absent']] ensure
#   Wether to use or to remove the group.
#
# @param [Stdlib::Absolutepath] key_path
#   Path to the file the key will save to.
#
# @param [Boolean] ssl
#   Wether to turn on TLS.
#
# @param [Array[Csync2::GroupBlock] blocks
#   Manages blocks of config snippets. A block has to be of datatype Hash and consists of
#   'includes', 'excludes' and 'actions' as keys. The 'actions' are also an Array of Hashes
#   and has to constist of 'pattern', 'exec', 'logfile' and 'do' as keys.
#
# @param [Enum['none', 'younger']] auto
#   Set resolution method if files have conflicts and doesn't know which to use.
#
define csync2::group (
  Array[Stdlib::Host]         $hosts,
  String                      $key,
  Enum['present', 'absent']   $ensure   = 'present',
  String                      $group    = $title,
  Stdlib::Absolutepath        $key_path = "/etc/csync2.key_${group}",
  Boolean                     $ssl      = true,
  Array[Csync2::GroupBlock]   $blocks   = {},
  Enum['none', 'younger']     $auto     = 'younger',
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
