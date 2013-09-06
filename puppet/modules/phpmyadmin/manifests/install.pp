class phpmyadmin::install {
  include yum

  package { $phpmyadmin::params::package_name:
    ensure => present,
    require => [Package["php", "php-mysql"],Yumrepo["epel"]],
  }

  package { ["php", "php-mysql"]:
    ensure => present,
  }
  
}