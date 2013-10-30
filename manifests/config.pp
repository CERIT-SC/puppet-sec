class sec::config (
  $conf_name,
  $daemon_args
) {
  case $::operatingsystem {
    debian,ubuntu: {
      augeas { 'sec':
        incl    => '/etc/default/sec',
        lens    => 'Shellvars.lns',
        context => '/files/etc/default/sec',
        notify  => Class['sec::service'],
        changes => [
          'set RUN_DAEMON yes',
          "set DAEMON_ARGS \"'${daemon_args}'\""
        ];
      }
    }

    default: {
      fail("Unsupported OS: ${::operatingsystem}")
    }
  }

  # Concatenated SEC configuration
  include concat::setup

  concat { $conf_name:
    owner  => 'root',
    group  => 'root',
    mode   => 0600,
    notify => Class['sec::service'],
  }

  sec::rule { 'base':
    order   => 0,
    header  => '',
    content => '# This is a Puppet generated file',
  }
}
