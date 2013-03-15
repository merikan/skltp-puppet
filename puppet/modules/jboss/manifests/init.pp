class jboss {

  include jboss::params, jboss::install, jboss::config, jboss::service

  require java
}