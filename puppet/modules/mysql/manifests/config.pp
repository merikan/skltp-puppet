class mysql::config {
  
  define drop_database( $db_name) {
    exec { "drop-${db_name}-db":
      unless => "/usr/bin/mysql -e \"show databases;\" | grep ${db_name}",
      command => "/usr/bin/mysql -e \"DROP DATABASE ${db_name}; FLUSH PRIVILEGES;\"",
      require => [ Class['mysql::install'], Class['mysql::service'] ]
    }
  }

  #drop_database {"test_database":
  #  db_name => "test"
  #}
}