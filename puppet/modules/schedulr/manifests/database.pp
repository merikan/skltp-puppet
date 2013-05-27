class schedulr::database {
  require mysql::config
  include schedulr::params

  mysql::utils::createdb {
    'schedulr':
    user => "root",
    host => '%',
  } ->
  exec { "run script ${schedulr::params::db_script_full}" :
    onlyif => "/usr/bin/test $(/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" --database=schedulr -e \"show tables;\" | wc -l) -eq 0",
    command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" --database=schedulr < ${schedulr::params::db_script_full}",
  } 
}