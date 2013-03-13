class java::install {

  package { $java::params::package_name:
    provider => rpm,
    ensure => installed,
    source => "/vagrant/puppet/files/${java::params::dist_name}"
    #source => "puppet:///files/${java::params::dist_name}"
  } 

}