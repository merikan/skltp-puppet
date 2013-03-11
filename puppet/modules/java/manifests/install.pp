class java::install {

  package { $java::params::package_name:
    provider => rpm,
    ensure => installed,
    source => "/vagrant/puppet/files/${java::params::package_name}"
    #source => "puppet:///files/${java::params::package_name}"

  } 
}