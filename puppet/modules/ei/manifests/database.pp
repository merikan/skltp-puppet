class ei::database {
  require mysql::config

  mysql::utils::mysqldb {
    'ei':
    user => "ei_user",
    password => "ei_password",
    host => '%',
    require => [ Class['mysql::config'], Class['mysql::service'] ],
  } ->
    exec { "populate ei database" :
    onlyif => "/usr/bin/test $(/usr/bin/mysql -u root -p\"${mysql::params::root_password}\" --database=ei -e \"show tables;\" | wc -l) -eq 0",
    command => "/usr/bin/mysql -u root -p\"${mysql::params::root_password}\"  --database=ei < /vagrant/puppet/modules/ei/files/sql/skapa-ei-tabell.sql",
  }

}