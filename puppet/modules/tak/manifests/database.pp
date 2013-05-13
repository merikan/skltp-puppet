class tak::database {
  require mysql
  include tak::params
  

  mysql::utils::mysqldb {
    'tak':
    user => "tkuser",
    password => "secret",
    host => '%',
    require => [ Class['mysql::install'], Class['mysql::service'] ],
  } ->
    exec { "db-unpack:${tak::params::distname}" : 
    command => "/usr/bin/unzip /vagrant/puppet/files/${tak::params::distname} -d /tmp",
    creates => "${$tak::params::distribution_path}",
  } ->
    exec { "populate database" :
    onlyif => "/usr/bin/test $(/usr/bin/mysql --database=tak -e \"show tables;\" | wc -l) -eq 0",
    command => "/usr/bin/mysql --database=tak < ${$tak::params::distribution_path}/sql/tp-admin-DDL.sql",
  } ->
  exec { "alter table anvandare" :
    onlyif => "/usr/bin/test $(/usr/bin/mysql --database=tak -e \"show tables;\" | grep Anvandare | wc -l) -ne 0",
    command => "/usr/bin/mysql --database=tak -e \"ALTER TABLE Anvandare RENAME TO anvandare;\"",
  } 

}