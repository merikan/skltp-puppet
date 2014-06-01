
class phpmyadmin::config {
  require phpmyadmin::install
  include apache::params
  
  replace { "phpmyadmin:allow_from_all":
    file => "${apache::params::configd_dir}/${phpmyadmin::params::package_name}.conf",
    pattern => "Allow from 127.0.0.1",
    replacement => "Allow from all"
  }


}