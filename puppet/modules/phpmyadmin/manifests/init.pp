class phpmyadmin {

  require  apache

  include phpmyadmin::params, phpmyadmin::install, phpmyadmin::config, phpmyadmin::service

}