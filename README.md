# Puppet SEC module

This module manages SEC (simple event correlator,
http://simple-evcorr.sourceforge.net/ ) installation,
configuration and startup.

### Overview

This is the Puppet SEC module.

### Requirements

Module has been tested on:

* Puppet 3.3
* Debian and RHEL/CentOS 6

Required modules:

* stdlib (https://github.com/puppetlabs/puppetlabs-stdlib)

# Quick Start

Install and start SEC with default config:

```puppet
include sec
```

Full configuration options:

```puppet
class { 'sec':
  enabled     => true|false,  # enable state
  packages    => [...],       # override list of packages to install
  service     => '...',       # override service name
  include_dir => '...',       # directory for Sec rules
  purge       => true|false,  # include_dir purge orphaned files
  recurse     => true|false,  # include_dir recurse
  inputs      => [...],       # list of input log files
  daemon_args => '...',       # ERB inline template with daemon args.
}
```

SEC rule options:

```puppet
sec::rule { name
  ensure   => present|absent,
  rulename => $title,
  content  => '...',
}
```

***

CERIT Scientific Cloud, <support@cerit-sc.cz>
