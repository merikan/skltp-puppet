class java::install {

  package { $java::params::package_name:
    ensure   => installed,
    provider => "$java::params::provider",
    source   => "/vagrant/puppet/files/${java::params::dist_name}",
  } 
 
}