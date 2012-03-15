class sec::service {
	service {
		'sec':
			ensure		=> running,
			enable		=> true,
			hasstatus	=> false,
	}
}
