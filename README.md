# Puppet SEC module

This module manages SEC (simple event correlator,
http://simple-evcorr.sourceforge.net/ ) installation,
configuration and startup.

### Overview

This is the Puppet SEC module.

### Requirements

Module has been tested on:

* Puppet 2.7
* Debian 6.0
* common modules: stdlib, concat

# Quick Start

Install and start SEC with default config:

    include sec

Configure SEC ruleset

    sec::rule { 'test':
        content => '...';
    }
