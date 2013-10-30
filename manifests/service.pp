class sec::service (
  $enabled,
  $service
) {
  $_ensure = $enabled ? {
    true  => running,
    false => stopped,
  }

  service { $service:
    ensure    => $_ensure,
    enable    => $enabled,
    hasstatus => false,
    pattern   => '/usr/bin/sec',
  }
}
