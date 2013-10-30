class sec::install (
  $enabled,
  $packages
) {
  $_ensure = $enabled ? {
    true  => present,
    false => absent
  }

  package { $packages:
    ensure => $_ensure,
  }
}
