class sec::install (
	$packages
) {
	package {
		$packages:
			ensure	=> present;
	}
}
