class activemq {

  include activemq::params, activemq::install, activemq::config, activemq::service

  require java
}