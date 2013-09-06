class apache::params {

  $docroot = "/var/www/html"

  $service = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => 'apache2',
    /(?i:SLES|OpenSuSE)/      => 'apache2',
    default                   => 'httpd',
  }

  $config_dir = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => '/etc/apache2',
    /(?i:SLES|OpenSuSE)/      => '/etc/apache2',
    freebsd                   => '/usr/local/etc/apache20',
    default                   => '/etc/httpd',
  }

}
