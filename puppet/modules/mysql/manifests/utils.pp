class mysql::utils {

  define mysqldb( $user, $password, $host='localhost' ) {
    exec { "create-${name}-db":
      unless => "/usr/bin/mysql -e \"show databases;\" | grep ${name}",
      command => "/usr/bin/mysql -e \"CREATE DATABASE ${name} character set utf8; GRANT ALL PRIVILEGES ON ${name}.* TO ${user}@'${host}' IDENTIFIED BY '${password}'; FLUSH PRIVILEGES;\"",
      require => [ Class['mysql::install'], Class['mysql::service'] ]
    }
  }

  define drop_database( $db_name) {
    exec { "drop_database: ${db_name}":
      onlyif => "/usr/bin/mysql -e \"show databases;\" | grep ${db_name}",
      command => "/usr/bin/mysql -e \"DROP DATABASE ${db_name}; FLUSH PRIVILEGES;\"",
      require => [ Class['mysql::install'], Class['mysql::service'] ]
    }
  }

  define drop_user( $db_user, $db_host) {
    exec { "drop_user-${db_user}@${db_host}":
      onlyif => "/usr/bin/mysql -e \"select user, host from mysql.user where user='${db_user}' and host='${db_host}';\" | grep ${db_host}",
      command => "/usr/bin/mysql -e \"DROP USER '${db_user}'@'${db_host}'; FLUSH PRIVILEGES;\"",
      require => [ Class['mysql::install'], Class['mysql::service'] ]
    }
  }

   
}