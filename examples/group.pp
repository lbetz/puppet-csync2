csync2::group { 'cluster':
  hosts  => ['node1.example.org', 'node2.example.org'],
  blocks => {
    0 => {
      'includes' => [ '/etc/csync2.cfg' ],
    },
  },
  key    => 'supersecret',
}

csync2::group { 'monitoring':
  hosts  => ['node1.example.org', 'node2.example.org'],
  blocks => {
    0 => {
      'includes' => [ '/etc/icinga2/features-available', '/etc/icinga2/features-enabled' ],
    },
    1 => {
      'includes' => [ '/etc/icingaweb2' ],
      'excludes' => [ '/etc/icingaweb2/modules/director', '/etc/icingaweb2/enabledModules/director' ],
    },
  },
  key    => 'supersecret',
}

