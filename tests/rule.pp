include sec

sec::rule { 'test1':
  content => '# Test1 rule content',
}

sec::rule { 'test2':
  ensure  => absent,
  content => '# Test2 rule content',
}

sec::rule { 'test3':
  content => '# Test3 rule content',
}
