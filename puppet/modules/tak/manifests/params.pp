class tak::params {
  $version = "1.3.1"
  $artifact = "tp-vagval-distribution"
  $distname = "${artifact}-${version}-dist.zip"
  $distribution_path = "/tmp/tp-vagval-distribution-${version}"

  $module_path = "/vagrant/puppet/modules/tak"
  $init_script = "init.sql"
  $testdata_script = "testdata.sql"
}