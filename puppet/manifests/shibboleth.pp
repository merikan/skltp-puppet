# Följer instruktion på https://wiki.shibboleth.net/confluence/display/SHIB2/IdPSPLocalTestInstall
#
# Grunder
# =======
#
# Fick manuell kör om unzip av tomcat6 mha 
# $ vagrant ssh shibboleth...
# $ /bin/tar -xzf /vagrant/puppet/files/apache-tomcat-6.0.39.tar.gz -C /opt/tomcat-6.0.39 --strip-components=1
#
# Lägg in i /etc/bachrc 
# $ sudo gedit
# export JAVA_HOME=/usr/java/default
# export PATH=$PATH:$JAVA_HOME/bin
#
#
# Setup httpd for ssl
# -------------------
#
# sudo yum install mod_ssl
#
# Se: http://www.unixmen.com/how-to-configure-apache-with-ssl-centos-6-4/
# (byt /cert --> /certs)
#
# sudo cp /vagrant/puppet/files/shibboleth/httpd/ssl.conf /etc/httpd/conf.d
#
# sudo cp /vagrant/puppet/files/shibboleth/httpd/certs/server.crt /etc/pki/tls/certs
# sudo cp /vagrant/puppet/files/shibboleth/httpd/certs/server.csr /etc/pki/tls/certs
# sudo cp /vagrant/puppet/files/shibboleth/httpd/certs/server.key /etc/pki/tls/certs
# sudo cp /vagrant/puppet/files/shibboleth/httpd/certs/server.key.bck /etc/pki/tls/certs
#
# sudo /etc/init.d/httpd restart
#
# TEST:
# $netstat -an | grep 443 
# tcp 0 0 :::443 :::* LISTEN 
# $ netstat -an | grep 80
# tcp 0 0 :::80 :::* LISTEN 
# unix 3 [ ] STREAM CONNECTED 12580


# IDP installation
# ================
#
# sudo yum install telnet
#
# sudo unzip /vagrant/puppet/binaries/rivta-box/shibboleth/shibboleth-identityprovider-2.4.0-bin.zip
# sudo chown -R skltp:skltp shibboleth-identityprovider-2.4.0/
# cd shibboleth-identityprovider-2.4.0/
#
# sudo mkdir /opt/tomcat-6.0.39/endorsed/
# sudo cp endorsed/*.jar /opt/tomcat-6.0.39/endorsed/
# sudo /etc/init.d/tomcat7 restart
#
# ### sudo ./install.sh ### FUNGERAR INTE PGA AVSAKNAD AV JAVA_HOME!!!
# sudo su
# ./install.sh
# Använd default värden (inklusive idp.example.com), ange password som lösenord.
# sudo cp /opt/shibboleth-idp/war/idp.war /opt/tomcat-6.0.39/webapps
#
# TEST: "curl http://33.33.33.33:8080/idp/profile/Status" skall ge svaret "ok"


# IDP konfiguration
# =================
#
# Bakgrundsmaterial: http://httpd.apache.org/docs/2.2/mod/mod_proxy.html
#
# REDAN FIXAT I SSL.CONF - FILEN!!!!
# Configure Apache by adding the following line to httpd.conf or ssl.conf in the SSL virtual host to pass requests for the IdP into Tomcat:
#   sudo find / -name httpd.conf
#   /etc/httpd/conf/httpd.conf
#
#   ProxyPass /idp/ ajp://localhost:8009/idp/
#
# Change Tomcat's /opt/tomcat-6.0.39/conf/server.xmlport 8009 AJP13 connector. 
# We'll add request.tomcatAuthentication="false" and Address="127.0.0.1" to allow Apache to send usernames to the IdP.
# <Connector port="8009"
#    enableLookups="false" redirectPort="8443" protocol="AJP/1.3"
#    request.tomcatAuthentication="false" address="127.0.0.1" />
#
# REDAN FIXAT I SSL.CONF - FILEN!!!!
# Define the following in httpd.conf or ssl.conf to force users to authenticate when accessing the RemoteUser handler.
# <Location /idp/Authn/RemoteUser>
#    AuthType Basic
#    AuthName "My Identity Provider"
#    AuthUserFile /usr/local/idp/credentials/user.db
#    require valid-user
# </Location>
#
# Create a test user or two using the htpasswdcommand.
# sudo mkdir -p /usr/local/idp/credentials
# sudo htpasswd -c /usr/local/idp/credentials/user.db myself
# sudo htpasswd -c /usr/local/idp/credentials/user.db magnus
#
# sudo /etc/init.d/tomcat7 restart
# sudo /etc/init.d/httpd restart
#
# TEST: "curl http://localhost/idp/profile/Status" skall ge svaret "ok"
# TEST: "curl -k https://localhost/idp/profile/Status" skall ge svaret "ok"


# SP installation
# ===============
#
# Se: https://wiki.shibboleth.net/confluence/display/SHIB2/NativeSPLinuxRPMInstall
#
# sudo cp /vagrant/puppet/files/shibboleth/security_shibboleth.repo /etc/yum.repos.d/
# sudo yum install shibboleth
#
# * Shibboleth configuration files will be placed at /etc/shibboleth/ and the necessary Apache configuration in /etc/httpd/conf.d/shib.conf
# * shibd will be installed to /usr/sbin and may be managed using /sbin/service and /sbin/chkconfig
# * An appropriate version of mod_shib and other pluggable modules will be installed to /usr/lib/shibboleth/
# * Logs will be located in /var/log/httpd/native.log and /var/log/shibboleth


# SP installation konfiguration
# =============================
#
# updated /etc/httpd/conf/httpd.conf
### PROVAR MED 127.0.0.1 ISTÄLLET
### ServerName desktop.local:80
# ServerName 127.0.0.1:80
# UseCanonicalName On
#
# sudo /etc/init.d/httpd restart
# sudo /sbin/service shibd start



# IDP - SP basic konfiguration
# ============================
#
# lagt på följande i /etc/hosts: idp.example.org ds.example.org sp.example.org
#
# SP: /etc/shibboleth/shibboleth2.xml:
#   Added remotely maintained metadata example
#         <MetadataProvider type="XML" uri="http://idp.example.org/idp/profile/Metadata/SAML"
#               backingFilePath="federation-metadata.xml" reloadInterval="7200">
#         </MetadataProvider>
#
# SP: /etc/shibboleth/shibd.logger: Set DEBUG logging using log4j.rootCategory=DEBUG, shibd_log, warn_log
#
# IDP: /opt/shibboleth-idp/conf/relying-party.xml:
#   Added MetadataProvider reading metadata from a URL. 
#         <metadata:MetadataProvider id="URLMD" xsi:type="metadata:FileBackedHTTPMetadataProvider"
#                           metadataURL="http://sp.example.org/Shibboleth.sso/Metadata"
#                           backingFile="/opt/shibboleth-idp/metadata/some-metadata.xml">
#         </metadata:MetadataProvider>
#
# Restart Tomcat, Apache, and shibd.
# sudo /etc/init.d/tomcat7 stop
# sudo /etc/init.d/tomcat7 start
# sudo /etc/init.d/httpd restart
# sudo /sbin/service shibd restart
#
# TEST: 
# https://sp.example.org/secure
# Ger: Error Message: No peer endpoint available to which to send SAML response
# 
# idp-access.log:
# 20140307T132841Z|127.0.0.1|idp.example.org:443|/profile/SAML2/Redirect/SSO|
#
# idp-process.log:
# 13:28:41.241 - INFO [Shibboleth-Access:73] - 20140307T132841Z|127.0.0.1|idp.example.org:443|/profile/SAML2/Redirect/SSO|
# 13:28:41.243 - WARN [org.opensaml.saml2.binding.AuthnResponseEndpointSelector:206] - Relying party 'https://sp.example.org/shibboleth' requested the response to be returned to endpoint with ACS URL 'https://127.0.0.1/Shibboleth.sso/SAML2/POST'  and binding 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST' however no endpoint, with that URL and using a supported binding,  can be found in the relying party's metadata 
# 13:28:41.243 - ERROR [edu.internet2.middleware.shibboleth.idp.profile.AbstractSAMLProfileHandler:447] - No return endpoint available for relying party https://sp.example.org/shibboleth
#
# httpd/ssl_access_log:
# 127.0.0.1 - magnus [07/Mar/2014:13:28:41 +0000] "GET /idp/Authn/RemoteUser HTTP/1.1" 302 -
# 127.0.0.1 - - [07/Mar/2014:13:28:41 +0000] "GET /idp/profile/SAML2/Redirect/SSO HTTP/1.1" 200 811
# 127.0.0.1 - - [07/Mar/2014:13:28:41 +0000] "GET /idp/images/dummylogo.png HTTP/1.1" 200 13742
# 127.0.0.1 - - [07/Mar/2014:13:28:41 +0000] "GET /favicon.ico HTTP/1.1" 404 285
# 
# httpd/ssl_request_log:
# [07/Mar/2014:13:28:41 +0000] 127.0.0.1 TLSv1 DHE-RSA-AES256-SHA "GET /idp/Authn/RemoteUser HTTP/1.1" -
# [07/Mar/2014:13:28:41 +0000] 127.0.0.1 TLSv1 DHE-RSA-AES256-SHA "GET /idp/profile/SAML2/Redirect/SSO HTTP/1.1" 811
# [07/Mar/2014:13:28:41 +0000] 127.0.0.1 TLSv1 DHE-RSA-AES256-SHA "GET /idp/images/dummylogo.png HTTP/1.1" 13742
# [07/Mar/2014:13:28:41 +0000] 127.0.0.1 TLSv1 DHE-RSA-AES256-SHA "GET /favicon.ico HTTP/1.1" 285
# 
# http://sp.example.org/Shibboleth.sso/Metadata returnerar:
#    <md:AssertionConsumerService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST" Location="http://127.0.0.1/Shibboleth.sso/SAML2/POST" index="1"/>
#
# https://sp.example.org/Shibboleth.sso/Session
# 
include shibboleth

# From desktop.pp
include setup
include soapui
include firefox
include graphical_desktop
include gedit

class setup {
    # turn of Text Mode setup Utility and NetworkManager
    service { ["firstboot","NetworkManager"]:
         enable => false,
         ensure => "stopped",
         require => Class['graphical_desktop'], 
    }
    # disable update notification
    file {'/etc/xdg/autostart/gpk-update-icon.desktop':
      ensure => 'absent',
      require => Class['graphical_desktop'], 
    }
    # enable automatic login
    file {'/etc/gdm/custom.conf':
      source => "/vagrant/puppet/files/cent-os-config/etc/gdm/custom.conf",
      owner => 'root',
      group => 'root',
      mode   => 644,
      require => Class['graphical_desktop'],
    }
}

class soapui {
  exec { "unpack-soapui" : 
    command => "/bin/tar -zxvf /vagrant/puppet/files/soapui-4.5.2-linux-bin.tar.gz -C /home/skltp",
    creates => "/home/skltp/soapui-4.5.2",
    user => 'skltp',
    require => Class['graphical_desktop'], 
  }

}

class firefox {
  package {
    'firefox':
    ensure => installed,
    require => Class['graphical_desktop'] ,
  } ->
  file {
    "/usr/lib/firefox/defaults/preferences/local-settings.js":
    source => "/vagrant/puppet/files/firefox/local-settings.js",
    owner => 'root',
    group => 'root',
    mode => 644,
  } ->
  file {
    "/usr/lib/firefox/mozilla.cfg":
    source => "/vagrant/puppet/files/firefox/mozilla.cfg",
    owner => 'root',
    group => 'root',
    mode   => 644,
  }
}

class graphical_desktop {
  case $::osfamily {
    'RedHat': {
      yumgroup { 'basic-desktop': }
      yumgroup { 'desktop-platform': }
      yumgroup { 'x11': }
      yumgroup { 'fonts': }
    }
    default: {
      fail("unsupported osfamily: $::osfamily")
    }
  }
  replace {"autostart of graphical login":
    file => "/etc/inittab",
    pattern => "id:3:initdefault:",
    replacement => 'id:5:initdefault:',
  }
}

class gedit {
  package{'gedit': ensure => installed }
}
define yumgroup($ensure = "present", $optional = false) {

   case $ensure {
      present,installed: {
         $pkg_types_arg = $optional ? {
            true => "--setopt=group_package_types=optional,default,mandatory",
            default => ""
         }
         exec { "Installing $name yum group":
            command => "/usr/bin/yum -y groupinstall $pkg_types_arg $name",
            unless => "/usr/bin/yum -y groupinstall $pkg_types_arg $name --downloadonly",
            timeout => 600,
         }
      }
   }
}

# From desktop.pp

class shibboleth {
  group { "skltp" : 
    ensure => present,
  } ->
  file { "/etc/sudoers.d/skltp":
    content => 'skltp        ALL=(ALL)       NOPASSWD: ALL',
    owner   => 'root',
    group  => 'root',
    mode    => '0440',
  } ->
  user { "skltp" : 
    password => '$1$voPKKtHf$OGf4XU6vrjWFlbpOjKLoF/',
    ensure => present,
    managehome => true,
    gid => "skltp",
    shell => "/bin/bash",
  } ->
  file { ['/home/skltp/Pictures/', '/home/skltp/Desktop/']:
    ensure => "directory",
    owner  => "skltp",
    group  => "skltp",
    mode   => 644,
  } ->
#  file {
#    "/home/skltp/Pictures/eHalsa_green_white_cmyk-81.png":
#    source => "/vagrant/puppet/files/shibboleth/shibboleth.png",
#    owner => 'skltp',
#    group => 'skltp',
#    mode   => 644,    # rw-r--r--    
#  } ->
  file {
    "/home/skltp/Desktop/gedit.desktop":
    source => "/vagrant/puppet/files/users/skltp/Desktop/gedit.desktop",
    owner => 'skltp',
    group => 'skltp',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/skltp/Desktop/gnome-terminal.desktop":
    source => "/vagrant/puppet/files/users/skltp/Desktop/gnome-terminal.desktop",
    owner => 'skltp',
    group => 'skltp',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/skltp/Desktop/gnome-nautilus-browser.desktop":
    source => "/vagrant/puppet/files/users/skltp/Desktop/gnome-nautilus-browser.desktop",
    owner => 'skltp',
    group => 'skltp',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/skltp/Desktop/mozilla-firefox.desktop":
    source => "/vagrant/puppet/files/users/skltp/Desktop/mozilla-firefox.desktop",
    owner => 'skltp',
    group => 'skltp',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/skltp/Desktop/soapUI.desktop":
    source => "/vagrant/puppet/files/users/skltp/Desktop/soapUI.desktop",
    owner => 'skltp',
    group => 'skltp',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/etc/sysconfig/keyboard":
    source => "/vagrant/puppet/files/cent-os-config/etc/sysconfig/keyboard",
    owner => 'root',
    group => 'root',
    mode   => 644,    # rw-r--r--    
  } ->
  exec { "gconftool-2":
    command => "/usr/bin/sudo -u skltp /usr/bin/gconftool-2 --load /vagrant/puppet/files/users/skltp/gconftool-2-dump.xml && /usr/bin/sudo touch /var/local/puppet::${title}::gconftool-2.semaphore",
    creates => "/var/local/puppet::${title}::gconftool-2.semaphore"
  }
    

  include base

  include java
#  include activemq 
#  include mule 
  include tomcat
#  include mysql
#  include phpmyadmin
#  include tak::database
#  include tak
#  include schedulr::database
#  include schedulr
  include iptables::disable
  include apache
#  include vp
#  include crasch_mule
#  include ei
#  include ei::database
#  include agt_tidbok
}
