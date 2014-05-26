class tak::database {
  require mysql
  include tak::params
  

  mysql::utils::mysqldb {
    'tak':
    user => "${tak::params::db_user}",
    password => "${tak::params::db_password}",
    host => '%',
    require => [ Class['mysql::config'], Class['mysql::service'] ],
  } ->
#    exec { "db-unpack:${tak::params::distname}" : 
#    command => "/usr/bin/unzip /vagrant/puppet/files/${tak::params::distname} -d /tmp",
#    creates => "${tak::params::distribution_path}",
#  } ->
  file {'tp-admin-DDL.sql-file':
    ensure => present,
    path   => '/tmp/tp-admin-DDL.sql',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/tak/tp-admin-DDL.sql',
  } ->
  exec { 'populate database' :
    onlyif => "/usr/bin/test $(/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" --database=tak -e \"show tables;\" | wc -l) -eq 0",
    command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\"  --database=tak < /tmp/tp-admin-DDL.sql",
  } ->
#  exec { "alter table anvandare" :
#    onlyif => "/usr/bin/test $(/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" --database=tak -e \"show tables;\" | grep Anvandare | wc -l) -ne 0",
#    command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\"  --database=tak -e \"ALTER TABLE Anvandare RENAME TO anvandare;\"",
#  } ->
  file {'init.sql-file':
    ensure => present,
    path   => "/tmp/init.sql",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///modules/tak/init.sql",
  } ->
  exec { "run script ${tak::params::init_script}" :
    command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\"  --database=tak < /tmp/init.sql && touch /var/local/puppet::${title}::init.sql.semaphore",
    creates => "/var/local/puppet::${title}::init.sql.semaphore",
  } ->
  file {'testdata.sql-file':
    ensure => present,
    path   => "/tmp/testdata.sql",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///modules/tak/testdata.sql",
  } ->
  exec { "run script ${tak::params::testdata_script}" :
    command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\"  --database=tak < /tmp/testdata.sql  && touch /var/local/puppet::${title}::testdata.sql.semaphore",
    creates => "/var/local/puppet::${title}::testdata.sql.semaphore",
  } 

}