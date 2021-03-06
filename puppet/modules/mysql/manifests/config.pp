class mysql::config {
  
  require utils


  exec { "set root password":
    command => "/usr/bin/mysqladmin -u root password '${mysql::params::root_password}'  && touch /var/local/puppet::${title}::set_root_password.semaphore",
    creates => "/var/local/puppet::${title}::set_root_password.semaphore",
    require => [ Class['mysql::service'] ]
  } ->
  mysql::utils::drop_database {
    "test":
    db_name => "test"
  } ->
  mysql::utils::drop_user {
    "@local":
    db_user => "",
    db_host => "localhost"
  } ->
  mysql::utils::drop_user {
    "${hostname}.local":
    db_user => "",
    db_host => "${hostname}.local"
  }

}