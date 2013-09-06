class phpmyadmin::params {

  case $::operatingsystem {
    'RedHat', 'CentOS': {
      $package_name          = 'phpMyAdmin'
    }
    /^(Debian|Ubuntu)$/: {
      $package_name          = 'phpmyadmin'
    }
    default: { 
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }


}
