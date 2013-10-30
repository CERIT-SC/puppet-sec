class sec::params {
  $enabled = true
  $purge = true
  $recurse = true
  $packages = ['sec']
  $include_dir = '/etc/sec/'
  $service = 'sec'

  $daemon_args = "-conf=<%= @include_dir %>/*.sec \
<% @inputs.each do |i| %>-input=<%= i %> <% end %> \
-intevents -syslog=daemon -detach -pid=/var/run/sec.pid"

  case $::operatingsystem {
    debian,ubuntu: {
      $inputs = ['/var/log/syslog']
    }

    redhat,eol,centos: {
      $inputs = ['/var/log/messages']
    }

    default: {
      fail("Unsupported OS: ${::operatingsystem}")
    }
  }
}
