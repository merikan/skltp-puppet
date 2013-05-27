class mysql::utils {

  $executor = "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\""
  notify{"The value of executor is: ${executor}": }

  # create user and database
  define mysqldb( $user, $password, $host='localhost' ) {
    exec { "create-${name}-db":
      unless => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" -e \"show databases;\" | grep ${name}",
      command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" -e \"CREATE DATABASE ${name} character set utf8; GRANT ALL PRIVILEGES ON ${name}.* TO ${user}@'${host}' IDENTIFIED BY '${password}'; FLUSH PRIVILEGES;\"",
      require => [ Class['mysql::install'], Class['mysql::service'] ]
    }
  }

  # create database
  define createdb( $user, $host='localhost' ) {
    exec { "create-${name}-db":
      unless => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" -e \"show databases;\" | grep ${name}",
      command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" -e \"CREATE DATABASE ${name} character set utf8; GRANT ALL PRIVILEGES ON ${name}.* TO ${user}@'${host}' WITH GRANT OPTION; FLUSH PRIVILEGES;\"",
      require => [ Class['mysql::install'], Class['mysql::service'] ]
    }
  }

  #drop database
  define drop_database( $db_name) {
    exec { "drop_database: ${db_name}":
      onlyif => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" -e \"show databases;\" | grep ${db_name}",
      command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" -e \"DROP DATABASE ${db_name}; FLUSH PRIVILEGES;\"",
      require => [ Class['mysql::install'], Class['mysql::service'] ]
    }
  }

  #drop user
  define drop_user( $db_user, $db_host) {
    exec { "drop_user-${db_user}@${db_host}":
      onlyif => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" -e \"select user, host from mysql.user where user='${db_user}' and host='${db_host}';\" | grep ${db_host}",
      command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" -e \"DROP USER '${db_user}'@'${db_host}'; FLUSH PRIVILEGES;\"",
      require => [ Class['mysql::install'], Class['mysql::service'] ]
    }
  }

   
}