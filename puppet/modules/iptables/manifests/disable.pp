class iptables::disable {
  include iptables::install


    case $::osfamily {
	  default: {warning("Not yet implemented for osfamily ${::osfamily}")}
	  'redhat': {
		  service {
		    'iptables':
		      ensure => stopped,
		      hasrestart => true,
		      enable => false,
		      require => Class['iptables::install']
		  }
	  }
	}
}
