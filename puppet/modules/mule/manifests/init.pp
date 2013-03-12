class mule {

  include mule::params, mule::install, mule::config, mule::service

  require java
}