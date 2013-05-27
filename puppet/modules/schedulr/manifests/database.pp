class schedulr::database {
  require mysql
  include schedulr::params
  

  mysql::utils::createdb {
    'schedulr':
    user => "root",
    host => '%',
    require => Class['mysql::service'],
  } ->
  exec { "run script ${schedulr::params::db_script_full}" :
    onlyif => "/usr/bin/test $(/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" --database=schedulr -e \"show tables;\" | wc -l) -eq 0",
    command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" --database=schedulr < ${schedulr::params::db_script_full}",
  } 
  # ERROR 1062 (23000) at line 29: Duplicate entry '1' for key 'PRIMARY'
  #->
  #exec { "run script ${schedulr::params::db_script_timeslots}" :
  #  command => "/usr/bin/mysql --database=schedulr < ${schedulr::params::db_script_timeslots}  && touch /var/local/${schedulr::params::artifact}.semaphore",
  #  creates => "/var/local/${schedulr::params::artifact}.semaphore",
  #} 
}