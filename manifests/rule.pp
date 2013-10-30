define sec::rule (
  $content,
  $ensure      = present,
  $rulename    = $title,
  $enabled     = $sec::enabled,
  $include_dir = $sec::include_dir
) {
  validate_bool($enabled)

  $_ensure = $enabled ? {
    true  => $ensure,
    false => $enabled,
  }

  file { "${include_dir}/${rulename}.sec":
    ensure => $_ensure,
    content => template('sec/rule.sec.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
  }

  if $enabled {
    File["${include_dir}/${rulename}.sec"] {
      notify => Class['sec::service'],
    }
  }
}
