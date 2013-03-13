
define replace($file, $pattern, $replacement) {
  exec { "/usr/bin/perl -pi -e 's/$pattern/$replacement/' '$file'":
      onlyif => "/usr/bin/perl -ne 'BEGIN { \$ret = 1; } \$ret = 0 if /$pattern/ && ! /$replacement/ ; END { exit \$ret; }' '$file'",
   }
}


include java
include tomcat
include mule 
include activemq 
include mysql


#mysql::utils::mysqldb {
#  "peter_db":
#  user => "peter",
#  password => "password",
#  host => '%'
#}



mysql::utils::drop_database {
  "peter_db":
  db_name => "peter_db"
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
