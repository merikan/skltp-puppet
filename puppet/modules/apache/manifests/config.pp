class apache::config  {
    require apache::install
    include apache::params

    file {
    "apache:index.html":
    path => "${apache::params::docroot}/index.html",
    source => "/vagrant/puppet/modules/apache/files/index.html",
    owner => 'apache',
    group => 'apache',
    notify => Class['apache::service'];
    "apache:images":
    path => "${apache::params::docroot}/images",
    source => "/vagrant/puppet/modules/apache/files/images",
    recurse => true,
    owner => 'apache',
    group => 'apache',
    notify => Class['apache::service'];
    "apache:css":
    path => "${apache::params::docroot}/css",
    source => "/vagrant/puppet/modules/apache/files/css",
    recurse => true,
    owner => 'apache',
    group => 'apache',
    notify => Class['apache::service'];
    "apache:js":
    path => "${apache::params::docroot}/js",
    source => "/vagrant/puppet/modules/apache/files/js",
    recurse => true,
    owner => 'apache',
    group => 'apache',
    notify => Class['apache::service'];
    "apache:logViewer":
    path => "${apache::params::docroot}/logViewer",
    source => "/vagrant/puppet/modules/apache/files/logViewer",
    recurse => true,
    owner => 'apache',
    group => 'apache',
    notify => Class['apache::service'];
    "apache:eiNotificationViewer":
    path => "${apache::params::docroot}/eiNotificationViewer",
    source => "/vagrant/puppet/modules/apache/files/eiNotificationViewer",
    recurse => true,
    owner => 'apache',
    group => 'apache',
    notify => Class['apache::service'];
    "apache:client.jks":
    path => "${apache::params::docroot}/client.jks",
    source => "/vagrant/puppet/modules/apache/files/client.jks",
    owner => 'apache',
    group => 'apache',
    notify => Class['apache::service'];
    "apache:skltp-soapui-project.xml":
    path => "${apache::params::docroot}/skltp-soapui-project.xml",
    source => "/vagrant/puppet/modules/apache/files/skltp-soapui-project.xml",
    owner => 'apache',
    group => 'apache',
    notify => Class['apache::service'];
  }

  # a ugly hack until we have created a user module
  file {
    'users:skltp:skltp-soapui-project.xml':
    path => "/home/skltp/skltp-soapui-project.xml",
    ensure  => file,
    source => "/vagrant/puppet/modules/apache/files/skltp-soapui-project.xml",
    owner => skltp,
    group => skltp;
    'users:skltp:client.jks':
    path => "/home/skltp/client.jks",
    source => "/vagrant/puppet/modules/apache/files/client.jks",
    owner => 'skltp',
    group => 'skltp';
    'users:skltp:soapui-settings.xml':
    path => "/home/skltp/soapui-4.5.2/soapui-settings.xml",
    ensure  => file,
    source => "/vagrant/puppet/modules/apache/files/soapui-settings.xml",
    owner => skltp,
    group => skltp,
    require => Class['soapui'];
    'users:skltp:soapui-skltp-workspace.xml':
    path => "/home/skltp/soapui-skltp-workspace.xml",
    ensure  => file,
    source => "/vagrant/puppet/modules/apache/files/soapui-skltp-workspace.xml",
    owner => skltp,
    group => skltp,
    require => Class['soapui'];
  } 
}
