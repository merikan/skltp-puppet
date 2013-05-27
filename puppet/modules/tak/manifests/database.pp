class tak::database {
  require mysql
  include tak::params
  

  mysql::utils::mysqldb {
    'tak':
    user => "tkuser",
    password => "secret",
    host => '%',
    require => [ Class['mysql::config'], Class['mysql::service'] ],
  } ->
    exec { "db-unpack:${tak::params::distname}" : 
    command => "/usr/bin/unzip /vagrant/puppet/files/${tak::params::distname} -d /tmp",
    creates => "${tak::params::distribution_path}",
  } ->
    exec { "populate database" :
    onlyif => "/usr/bin/test $(/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" --database=tak -e \"show tables;\" | wc -l) -eq 0",
    command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\"  --database=tak < ${tak::params::distribution_path}/sql/tp-admin-DDL.sql",
  }->
  exec { "alter table anvandare" :
    onlyif => "/usr/bin/test $(/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" --database=tak -e \"show tables;\" | grep Anvandare | wc -l) -ne 0",
    command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\"  --database=tak -e \"ALTER TABLE Anvandare RENAME TO anvandare;\"",
  } ->
  exec { "run script ${tak::params::dbscript}" :
    command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\"  --database=tak < ${tak::params::module_path}/files/${tak::params::dbscript}  && touch /var/local/${title}-${tak::params::dbscript}.semaphore",
    creates => "/var/local/${title}-${tak::params::dbscript}.semaphore",
  } 

}