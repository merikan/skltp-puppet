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
    command => "/bin/tar -xzf /vagrant/puppet/files/${tak::params::distname} --directory /tmp",
    creates => "${tak::params::distribution_path}",
  } -> 
  replace { "TYPE=INNODB to ENGINE=InnoDB":
    file => "${tak::params::distribution_path}/sql/tp-admin-DDL.sql",
    pattern => "TYPE=INNODB",
    replacement => "ENGINE=InnoDB"
  } ->
  exec { "populate database" :
    onlyif => "/usr/bin/test $(/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" --database=tak -e \"show tables;\" | wc -l) -eq 0",
    command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\"  --database=tak < ${tak::params::distribution_path}/sql/tp-admin-DDL.sql",
  } ->
  exec { "alter table anvandare" :
    onlyif => "/usr/bin/test $(/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" --database=tak -e \"show tables;\" | grep Anvandare | wc -l) -ne 0",
    command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\"  --database=tak -e \"ALTER TABLE Anvandare RENAME TO anvandare;\"",
  } ->
  exec { "run script ${tak::params::init_script}" :
    command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\"  --database=tak < ${tak::params::module_path}/files/${tak::params::init_script}  && touch /var/local/puppet::${title}::${tak::params::init_script}.semaphore",
    creates => "/var/local/puppet::${title}::${tak::params::init_script}.semaphore",
  } ->
  exec { "run script ${tak::params::testdata_script}" :
    command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\"  --database=tak < ${tak::params::module_path}/files/${tak::params::testdata_script}  && touch /var/local/puppet::${title}::${tak::params::testdata_script}.semaphore",
    creates => "/var/local/puppet::${title}::${tak::params::testdata_script}.semaphore",
  } 

}