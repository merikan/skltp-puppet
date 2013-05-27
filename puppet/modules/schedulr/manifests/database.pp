class schedulr::database {
  require mysql
  include schedulr::params
  

  mysql::utils::createdb {
    'schedulr':
    user => "root",
    host => '%',
    require => Class['mysql::service'],
  } 
  #->
  #exec { "populate database" :
  #  onlyif => "/usr/bin/test $(/usr/bin/mysql --database=schedulr -e \"show tables;\" | wc -l) -eq 0",
  #  command => "/usr/bin/mysql --database=schedulr < ${$tak::params::distribution_path}/sql/tp-admin-DDL.sql",
  #} ->
  #exec { "alter table anvandare" :
  #  onlyif => "/usr/bin/test $(/usr/bin/mysql --database=tak -e \"show tables;\" | grep Anvandare | wc -l) -ne 0",
  #  command => "/usr/bin/mysql --database=tak -e \"ALTER TABLE Anvandare RENAME TO anvandare;\"",
  #} 

}