class mysql::params {

  $root_password = "secret"

  case $::osfamily {
	default: {fail("Unsupported osfamily ${::osfamily}")}
	'redhat': {
	  $service_name         = 'mysqld'
	}
	'debian': {
      $service_name         = 'mysql'
	}
  }

}