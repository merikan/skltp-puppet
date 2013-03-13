class mysql::service {
  service { 'mysqld':
    enable => true,
    ensure => running,
    hasstatus => true,
    require => [ Class['mysql::install'] ]
  }
}