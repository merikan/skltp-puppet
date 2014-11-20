class java8::params {

    case $::osfamily {
	  default: {fail("Unsupported osfamily ${::osfamily}")}
	  'redhat': {
	  	$provider	    = 'rpm'
	    $package_name   = 'jdk-1.8.0_25-fcs.i586'
	    $dist_name      = "jdk-8u25-linux-i586.rpm"
	  }
	  'debian': {
	  	$provider		= 'dpkg'
	    $package_name   = 'jdk_1.8.025-1_i386.deb'
	    $dist_name      = "jdk_1.8.025-1_i386.deb"
	  }
	}

}
