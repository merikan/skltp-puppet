class java8::install {

  package { $java8::params::package_name:
    ensure   => installed,
    provider => "$java8::params::provider",
    source   => "/vagrant/puppet/binaries/dev-box/${java8::params::dist_name}",
  } 
 
}