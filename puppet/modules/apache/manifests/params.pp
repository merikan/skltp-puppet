class apache::params {
  case $::osfamily {
    default: {fail("Unsupported osfamily ${::osfamily}")}
    'redhat': {
      $user                 = 'apache'
      $group                = 'apache'
      $package_name         = 'httpd'
      $service_name         = 'httpd'
      $docroot              = '/var/www/html'
      $httpd_dir            = '/etc/httpd'
      $server_root          = '/etc/httpd'
      $conf_dir             = "${httpd_dir}/conf"
      $confd_dir            = "${httpd_dir}/conf.d"
      $conf_file            = "${$conf_dir}/httpd.conf"
      $conf_template        = '/vagrant/puppet/modules/apache/files/conf/httpd.conf'
      $pidfile              = 'run/httpd.pid'
      $error_log_file       = 'logs/error_log'
      $access_log_file      = 'logs/access_log'
      $icons_path           = '/var/www/icons'
      $cgi_bin_path         = '/var/www/cgi-bin/' 
      $error_documents_path = '/var/www/error'
      $modules_path         = 'modules'
    }
    'debian': {
      $user                 = 'www-data'
      $group                = 'www-data'
      $package_name         = 'apache2'
      $service_name         = 'apache2'
      $docroot              = '/var/www'
      $httpd_dir            = '/etc/apache2'
      $server_root          = '/etc/apache2'
      $conf_dir             = $httpd_dir
      $confd_dir            = "${httpd_dir}/conf.d"
      $conf_file            = "${$conf_dir}/apache2.conf"
      $conf_template        = '/vagrant/puppet/modules/apache/files/conf/apache2.conf'
      $pidfile              = '${APACHE_PID_FILE}'
      $error_log_file       = '${APACHE_LOG_DIR}/error.log'
      $access_log_file      = '${APACHE_LOG_DIR}/access.log'
      $icons_path           = '/usr/share/apache2/icons/'
      $cgi_bin_path         = '/usr/lib/cgi-bin'
      $error_documents_path = '/usr/share/apache2/error'
      $modules_path         = '/usr/lib/apache2/modules/'
    }
  }
}
