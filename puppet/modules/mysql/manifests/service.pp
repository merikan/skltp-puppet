class mysql::service {
  service { 'mysqld':
    enable => true,
    ensure => running,
    require => [ Class['mysql::install'] ]
  }
}