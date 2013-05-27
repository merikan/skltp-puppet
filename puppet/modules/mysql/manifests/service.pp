class mysql::service {
  require mysql::install

  service { 'mysqld':
    enable => true,
    ensure => running
  }
}