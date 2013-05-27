class mysql {

  include mysql::params, mysql::install, mysql::config, mysql::service

  Class[mysql::install] -> Class['mysql::service'] -> Class['mysql::config']
}