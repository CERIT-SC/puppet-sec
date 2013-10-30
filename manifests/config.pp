class sec::config (
  $enabled,
  $purge,
  $recurse,
  $include_dir,
  $daemon_args
) {
  $_ensure = $enabled ? {
    true  => directory,
    false => absent,
  }

  # obsolete, cleanups
  file { '/etc/sec.conf':
    ensure => absent,
  }

  file { $include_dir:
    ensure  => $_ensure,
    purge   => $purge,
    recurse => $recurse,
    force   => true,
  }

  case $::operatingsystem {
    debian,ubuntu: {
      $_run = $enabled ? {
        true    => 'yes',
        default => 'no'
      }

      augeas { 'sec':
        incl    => '/etc/default/sec',
        lens    => 'Shellvars.lns',
        context => '/files/etc/default/sec',
        changes => [
          "set RUN_DAEMON ${_run}",
          "set DAEMON_ARGS \"'${daemon_args}'\""
        ];
      }
    }

    redhat,eol,centos: {
      augeas { 'sec':
        incl    => '/etc/sysconfig/sec',
        lens    => 'Sysconfig.lns',
        context => '/files/etc/sysconfig/sec',
        changes => "set SEC_ARGS \"${daemon_args}\"",
      }
    }

    default: {
      warning("Unsupported OS: ${::operatingsystem}")
    }
  }
}
