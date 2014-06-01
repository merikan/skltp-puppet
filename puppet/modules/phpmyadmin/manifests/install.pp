class phpmyadmin::install {

	case $::osfamily {
	  default: {fail("Unsupported osfamily ${::osfamily}")}
	  'redhat': {
	  	  include yum
		  package { $phpmyadmin::params::package_name:
		    ensure => present,
		    require => [Package["php", "php-mysql"],Yumrepo["epel"]],
		  }
		  package { ["php", "php-mysql"]:
		    ensure => present,
		  }
	  }
	  'debian': {
		  package { $phpmyadmin::params::package_name:
		    ensure => present,

		  }

	  }
	}
  
}