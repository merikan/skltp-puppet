class mysql::config {
  

  mysql::utils::drop_database {
    "test":
    db_name => "test"
  }
  mysql::utils::drop_user {
    "@local":
    db_user => "",
    db_host => "localhost"
  }

  mysql::utils::drop_user {
    "${hostname}.local":
    db_user => "",
    db_host => "${hostname}.local"
  }

}