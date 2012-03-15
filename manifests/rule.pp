define sec::rule (
	$order		= 10,
	$ensure		= present,
	$conf_name	= $sec::conf_name,
	$header		= "\n\n# Puppet SEC rule '${name}'\n",
	$content
) {
	concat::fragment {
		"${conf_name}-${name}":
			target  => $conf_name,
			order	=> $order,
			content	=> "${header}${content}",
	}
}
