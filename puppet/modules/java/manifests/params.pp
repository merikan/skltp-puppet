class java::params {

    case $::osfamily {
	  default: {fail("Unsupported osfamily ${::osfamily}")}
	  'redhat': {
	  	$provider	    = 'rpm'
	    $package_name   = 'jdk-1.7.0_25-fcs.i586'
	    $dist_name      = "jdk-7u25-linux-i586.rpm"
	  }
	  'debian': {
	  	$provider		= 'dpkg'
	    $package_name   = 'jdk_1.7.025-1_i386.deb'
	    $dist_name      = "jdk_1.7.025-1_i386.deb"
	  }
	}

}
