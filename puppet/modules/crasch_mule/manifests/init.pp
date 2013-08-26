class crasch_mule {

  include crasch_mule::params, crasch_mule::install, crasch_mule::config, crasch_mule::service

  require  mule

}