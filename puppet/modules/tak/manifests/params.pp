class tak::params {
  $version = "1.5.0"
  $artifact = "tk-parent"
  $distname = "${artifact}-${version}-dist.tar.gz"
  $distribution_path = "/tmp/${artifact}-${version}"

  $module_path = "/vagrant/puppet/modules/tak"
  $init_script = "init.sql"
  $testdata_script = "testdata.sql"
}