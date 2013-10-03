class schedulr::params {

  $version = "0.5"
  $artifact = "Schedulr"
  $fqn = "${artifact}-${version}"   
  $distname = "${fqn}.war"
  $module_path = "/vagrant/puppet/modules/schedulr"
  $db_script_full = "${module_path}/files/schedulr-full-example-backup.sql"
  $db_script_timeslots = "${module_path}/files/schedulr-insert-timeslots.sql"
}