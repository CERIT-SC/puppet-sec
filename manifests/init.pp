class sec (
	$packages		= $sec::params::packages,
	$inputs			= $sec::params::inputs,
	$conf_name		= $sec::params::conf_name,
	$daemon_args	= $sec::params::daemon_args
) inherits sec::params {

	import 'stdlib'

	class {
		'sec::install':
			packages	=> $packages;
		'sec::config':
			conf_name	=> $conf_name,
			daemon_args	=> inline_template($daemon_args);
		'sec::service':
			;
	}

	anchor { 'sec::begin': ; }
		-> Class['sec::install']
		-> Class['sec::config']
		-> Class['sec::service']
		-> anchor { 'sec::end': ; }
}
