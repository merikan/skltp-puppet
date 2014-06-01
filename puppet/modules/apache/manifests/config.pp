class apache::config  {
  require apache::install
  include apache::params

  file {
    "${::apache::params::conf_file}":
    ensure  => file,
    path => "${apache::params::conf_file}",
    source => "${apache::params::conf_template}",
    owner => "${apache::params::user}",
    group => "${apache::params::group}",
    mode   => 644,
    notify => Class['apache::service'];
    "apache:index.html":
    path => "${apache::params::docroot}/index.html",
    source => "/vagrant/puppet/modules/apache/files/index.html",
    owner => "${apache::params::user}",
    group => "${apache::params::group}";
    "apache:images":
    path => "${apache::params::docroot}/images",
    source => "/vagrant/puppet/modules/apache/files/images",
    recurse => true,
    owner => "${apache::params::user}",
    group => "${apache::params::group}";
    "apache:css":
    path => "${apache::params::docroot}/css",
    source => "/vagrant/puppet/modules/apache/files/css",
    recurse => true,
    owner => "${apache::params::user}",
    group => "${apache::params::group}";
    "apache:js":
    path => "${apache::params::docroot}/js",
    source => "/vagrant/puppet/modules/apache/files/js",
    recurse => true,
    owner => "${apache::params::user}",
    group => "${apache::params::group}";
    "apache:logViewer":
    path => "${apache::params::docroot}/logViewer",
    source => "/vagrant/puppet/modules/apache/files/logViewer",
    recurse => true,
    owner => "${apache::params::user}",
    group => "${apache::params::group}";
    "apache:eiNotificationViewer":
    path => "${apache::params::docroot}/eiNotificationViewer",
    source => "/vagrant/puppet/modules/apache/files/eiNotificationViewer",
    recurse => true,
    owner => "${apache::params::user}",
    group => "${apache::params::group}",
    notify => Class['apache::service'];
    "apache:client.jks":
    path => "${apache::params::docroot}/client.jks",
    source => "/vagrant/puppet/modules/soapui/files/client.jks",
    owner => "${apache::params::user}",
    group => "${apache::params::group}";
    "apache:skltp-soapui-project.xml":
    path => "${apache::params::docroot}/skltp-soapui-project.xml",
    source => "/vagrant/puppet/modules/soapui/files/skltp-soapui-project.xml",
    owner => "${apache::params::user}",
    group => "${apache::params::group}";
  }
}
