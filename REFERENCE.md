# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

#### Public Classes

* [`csync2`](#csync2): Manages cluster software Csync2.

#### Private Classes

* `csync2::config`: This class exists to manage general configuration files needed by Csync2 to run.
* `csync2::globals`: Manages cluster software Csync2.
This class loads the default platform depending parameters by doing a hiera lookup.
* `csync2::install`: This class handles the insatll of csync2.
* `csync2::service`: This class handles the Csync2 service. By default the service will
start on boot and will be restarted if stopped.

### Defined types

* [`csync2::group`](#csync2group): Manages a Csync2 group.

### Data types

* [`Csync2::GroupBlock`](#csync2groupblock): A strict type for group blocks
* [`Csync2::GroupBlockAction`](#csync2groupblockaction): A strict type for group block actions

## Classes

### `csync2`

Manages cluster software Csync2.

#### Examples

##### Configures and install csync2 and also uses a preinstalled certificate and private key. Also a cronjob is needed to trigger the sync:

```puppet
include csync2

cron { 'csync2':
  command => "${::csync2::globals::csync2_bin} -x",
  user    => 'root',
}
```

##### The management of certificate and private key.

```puppet
class { 'csync2':
  ssl_cert => '-----BEGIN CERTIFICATE----- ...',
  ssl_key  => '----BEGIN RSA PRIVATE KEY----- ...',
}
```

##### Create two groups to sync. For more details have a look at defined resource 'group'.

```puppet
class { 'csync2':
  groups => {
    'cluster' => {
      hosts  => ['node1.example.org', 'node2.example.org'],
      blocks => [{
        'includes' => [ '/etc/csync2.cfg' ],
      }],
      key    => 'supersecret',
    },
    'monitoring' => {
      hosts  => ['node1.example.org', 'node2.example.org'],
      blocks => [{
        'includes' => [ '/etc/icingaweb2' ],
        'excludes' => [ '/etc/icingaweb2/modules/director', '/etc/icingaweb2/enabledModules/director' ],
      }],
      key    => 'supersecret',
    },
  },
}
```

#### Parameters

The following parameters are available in the `csync2` class.

##### `ensure`

Data type: `Stdlib::Ensure::Service`

Whether the Csync2 service should be running or is stopped.

Default value: `'running'`

##### `enable`

Data type: `Boolean`

Whether to enable the Csync2 service at boot.

Default value: ``true``

##### `manage_package`

Data type: `Boolean`

Whether to install a Csync2 package.

Default value: ``true``

##### `manage_service`

Data type: `Boolean`

Whether to handle the Csync2 service.

Default value: ``true``

##### `port`

Data type: `Stdlib::Port::Unprivileged`

Port ion Csync2 listens. Only effects if service is used.

Default value: `30865`

##### `ssl_cert`

Data type: `Optional[Stdlib::Base64]`

The certificate to use for TLS connections. It will be stored into the file specified in ssl_cert_path.
If is set, you've also to set parameter ssl_key. Leaving both unset, you must manage the content of
ssl_cert_path and ssl_key_path yourself.

Default value: ``undef``

##### `ssl_key`

Data type: `Optional[Stdlib::Base64]`

The private key to use for TLS connections. It will be stored into the file specified in ssl_key_path.
If is set, you've also to set parameter ssl_cert. Leaving both unset, you must manage the content of
ssl_cert_path and ssl_key_path yourself.

Default value: ``undef``

##### `groups`

Data type: `Hash[String, Hash]`

Handles one or more groups.

Default value: `{}`

## Defined types

### `csync2::group`

Manages a Csync2 group.

#### Examples

##### A simple example to sync the csync2 config itself.

```puppet
csync2::group { 'cluster':
  hosts  => ['node1.example.org', 'node2.example.org'],
  blocks => [
    {
      'includes' => [ '/etc/csync2.cfg' ],
    },
  ],
  key    => 'supersecret',
}
```

##### A more complex example with two blocks and actions.

```puppet
csync2::group { 'monitoring':
  hosts  => ['node1.example.org', 'node2.example.org'],
  blocks => [
    {
      'includes' => [ '/etc/icinga2/features-available', '/etc/icinga2/features-enabled' ],
      'actions'  => [
        {
          'pattern' => [ '/etc/icinga2/features-enabled/*' ],
          'exec'    => [ 'systemctl reload icinga2' ],
          'logfile' => '/var/log/csync2_action.log',
          'do'      => 'do-local',
        },
      ],
    },
    {
      'includes' => [ '/etc/icingaweb2' ],
      'excludes' => [ '/etc/icingaweb2/modules/director', '/etc/icingaweb2/enabledModules/director' ],
    },
  ],
  key    => 'supersecret-2',
}
```

#### Parameters

The following parameters are available in the `csync2::group` defined type.

##### `hosts`

Data type: `Array[Stdlib::Host]`

All involved hosts of the group.

##### `key`

Data type: `String`

The symmetric key to authenticate hosts to each other.

##### `ensure`

Data type: `Enum['present', 'absent']`

Wether to use or to remove the group.

Default value: `'present'`

##### `key_path`

Data type: `Optional[Stdlib::Absolutepath]`

Path to the file the key will save to.

Default value: ``undef``

##### `blocks`

Data type: `Array[Csync2::GroupBlock]`

Manages blocks of config snippets. A block has to be of datatype Hash and consists of
'includes', 'excludes' and 'actions' as keys. The 'actions' are also an Array of Hashes
and has to constist of 'pattern', 'exec', 'logfile' and 'do' as keys.

Default value: `{}`

##### `auto`

Data type: `Enum['none', 'younger']`

Set resolution method if files have conflicts and doesn't know which to use.

Default value: `'younger'`

##### `group`

Data type: `String`



Default value: `$title`

## Data types

### `Csync2::GroupBlock`

A strict type for group blocks

Alias of `Struct[{
  includes           => Array[String],
  Optional[excludes] => Array[String],
  Optional[actions]  => Array[Csync2::GroupBlockAction],
}]`

### `Csync2::GroupBlockAction`

A strict type for group block actions

Alias of `Struct[{
  pattern           => Array[String],
  exec              => Array[String],
  Optional[logfile] => Stdlib::Absolutepath,
  Optional[do]      => Enum['do-local', 'do-local-only'],
}]`

