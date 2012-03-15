class sec::params {
	case $::operatingsystem {
		debian,ubuntu: {
			$inputs		= ['/var/log/syslog']
		}

		fedora,redhat,eol,centos: {
			$inputs		= ['/var/log/messages']
		}

		default: {
			fail("Unsupported OS (${::operatingsystem})")
		}
	}

	if $packages == ''		{ $packages 	= ['sec'] }
	if $inputs == ''		{ $inputs 		= [] }
	if $conf_name == ''		{ $conf_name	= '/etc/sec.conf' }
	if $daemon_args  == '' 	{ $daemon_args	= '-conf=<%= conf_name %> <% @inputs.each do |i| %>--input=<%= i %> <% end %>-intevents -syslog=daemon -detach -pid=/var/run/sec.pid' }

	if is_array($inputs) != true {
		fail('$inputs must be array')
	}
}
