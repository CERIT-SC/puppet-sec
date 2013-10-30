class sec (
  $enabled     = $sec::params::enabled,
  $packages    = $sec::params::packages,
  $purge       = $sec::params::purge,
  $recurse     = $sec::params::recurse,
  $include_dir = $sec::params::include_dir,
  $service     = $sec::params::service,
  $inputs      = $sec::params::inputs,
  $daemon_args = $sec::params::daemon_args
) inherits sec::params {

  validate_bool($enabled, $purge, $recurse)
  validate_array($packages, $inputs)

  class { 'sec::install':
    enabled  => $enabled,
    packages => $packages,
  }

  class { 'sec::config':
    enabled     => $enabled,
    include_dir => $include_dir,
    purge       => $purge,
    recurse     => $recurse,
    daemon_args => inline_template($daemon_args),
  }

  class { 'sec::service':
    enabled => $enabled,
    service => $service,
  }

  if $enabled {
    anchor { 'sec::begin': ; }
      -> Class['sec::install']
      -> Class['sec::config']
      ~> Class['sec::service']
      -> anchor { 'sec::end': ; }
  } else {
    anchor { 'sec::begin': ; }
      -> Class['sec::service']
      -> Class['sec::config']
      -> Class['sec::install']
      -> anchor { 'sec::end': ; }
  }
}
