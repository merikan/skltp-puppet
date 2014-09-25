
class phpmyadmin::config {
  require phpmyadmin::install
  include apache::params
  
  replace { "phpmyadmin:allow_from_all":
    file => "${apache::params::confd_dir}/${phpmyadmin::params::package_name}.conf",
    pattern => "Deny from All",
    replacement => "Allow from All"
  }

}