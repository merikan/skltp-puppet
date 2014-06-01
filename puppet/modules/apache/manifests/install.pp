class apache::install {
  include apache::params
  package {'apache':
    ensure => 'installed',
    name   => "${apache::params::package_name}",
  }
}
