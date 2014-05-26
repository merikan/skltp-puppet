class tak::params {
  $version = "1.4.0"
  #$artifact = "tp-vagval-distribution"
  #$distname = "${artifact}-${version}-dist.zip"
  #$distribution_path = "/tmp/tp-vagval-distribution-${version}"

  $db_user = 'tak'
  $db_password = 'secret'

  $module_path = "/vagrant/puppet/modules/tak"
  $ddl_script = "tp-admin-DDL.sql"
  $init_script = "init.sql"
  $testdata_script = "testdata.sql"
}