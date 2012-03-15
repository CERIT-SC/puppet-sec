include sec

sec::rule {
	'test1':
		content	=> '# Test1 rule content';
	'test2':
		ensure	=> absent,
		content	=> '# Test2 rule content';
	'test3':
		header	=> "\n\n# Puppet SEC rule with custom header\n",
		content	=> '# Test3 rule content';
}
