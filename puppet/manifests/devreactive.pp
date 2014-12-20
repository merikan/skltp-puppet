## skall vi verkligen ha denna? Borde paketera en ny base box som är en desktop box istället.

# TODO: 
#
# - Se https://github.com/callistaenterprise/cm-tools/wiki/Exportera-en-rivta-box
#
# - Säkerställ att Firefox startar med startsidan
#
# - Auto login + longer lock time of gui (rdan fixat av länken ovan?)
#
# - Automatic Eclipse import
#   - https://github.com/seeq12/eclipse-import-projects-plugin
#   - http://stackoverflow.com/questions/11302297/automate-import-of-java-android-projects-into-eclipse-workspace-through-comman
# - setup av smart git
#   - I understand + 30 days evluation
#   - Use SmartGit as SSH client
#   - Blank user info
#   - No Git provider
#   - Accept existing git repo
#   - Accept error reporting defaults
#   - Checka ut de tre andra brancherna så att de hämtas hem som lokala brancher
#   - Checka ut master branchen igen
# - setup en terminator session med fyra fönster
#   - service provider
#   - exercise x
#   - rtlt
#   - curl

include devreactive

class devreactive {
  include base
  include java8
  include git
  include dev-user
  include dev-system
  include firefox
  include terminator
  include gedit
  include emacs
  include gnome-system-monitor
  include gdkpixbuf2
  include eclipse
  include smartgit
#  include tomcat
#  include tomcat-config

#  include setup ### GÅR INTE ATT STARTA OM BOXEN OM JAG LGER PÅ DETTA!!!
}

class tomcat-config {
  file {"tomcat:server.xml":
    path => "${tomcat::params::tomcat_home}/conf/server.xml",
    source => "/vagrant/puppet/files/users/dev-user/config/tomcat/server.xml",
    owner => 'tomcat',
    group => 'tomcat',
    require => Class['tomcat'] ,
  } ->
    
  file {"tomcat:rtlt.war":
    path => "${tomcat::params::tomcat_home}/webapps/rtlt.war",
    source => "/vagrant/puppet/files/realtime-load-tester-1.0.0-SNAPSHOT.war",
    owner => 'tomcat',
    group => 'tomcat',
    require => Class['tomcat'] ,
  }
}

class eclipse {
  exec { "eclipse-unpack-dist": 
    command => "/bin/tar -xzf /vagrant/puppet/binaries/dev-box/eclipse-java-luna-SR1-linux-gtk.tar.gz -C /home/user",
    user => user,
    creates => "/home/user/eclipse",
  }
}

class smartgit {
  exec { "smartgit-unpack-dist": 
    command => "/bin/tar -xzf /vagrant/puppet/binaries/dev-box/smartgit-generic-6_5_0.tar.gz -C /home/user",
    user => user,
    creates => "/home/user/smartgit",
  }
}

class dev-system {
  file { "limits.conf":
    path => "/etc/security/limits.conf",
    source => "/vagrant/puppet/files/users/dev-user/config/system/etc/security/limits.conf",
    owner   => 'root',
    group  => 'root'
  }
}

class dev-user {
  
  group { "user" : 
    ensure => present,
  } ->
  file { "/etc/sudoers.d/user":
    content => 'user        ALL=(ALL)       NOPASSWD: ALL',
    owner   => 'root',
    group  => 'root',
    mode    => '0440',
  } ->
  user { "user" :
    password => '$1$CbXLhSCO$CI5BYt7/JfEetbsA9z.dE1', # nio4you
    # password => '$1$voPKKtHf$OGf4XU6vrjWFlbpOjKLoF/', # skltp
    # password => '$1$1Z3LzjY/$3Jstuji.AS7VLYfRKai3f.', # mac4ever  
    ensure => present,
    managehome => true,
    gid => "user",
    shell => "/bin/bash",
  } ->
  file { ['/home/user/Pictures/', '/home/user/Desktop/']:
    ensure => "directory",
    owner  => "user",
    group  => "user",
    mode   => 644,
  } ->
  file {"user:index.html":
    path => "/home/user/index.html",
    source => "/vagrant/puppet/files/users/dev-user/index.html",
    owner => 'user',
    group => 'user',
  } ->    
  file {"user:rtlt.jar":
    path => "/home/user/rtlt.war",
    source => "/vagrant/puppet/files/realtime-load-tester-1.0.0-SNAPSHOT.war",
    owner => 'user',
    group => 'user',
  } ->
  file {
    "/home/user/Pictures/Callista_vit.png":
    source => "/vagrant/puppet/files/users/dev-user/Pictures/Callista_vit.png",
    owner => 'user',
    group => 'user',
    mode   => 644,    # rw-r--r--    
  } ->
  file {
    "/home/user/Desktop/Eclipse.desktop":
    source => "/vagrant/puppet/files/users/dev-user/Desktop/Eclipse.desktop",
    owner => 'user',
    group => 'user',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/user/Desktop/emacs.desktop":
    source => "/vagrant/puppet/files/users/dev-user/Desktop/emacs.desktop",
    owner => 'user',
    group => 'user',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/user/Desktop/terminator.desktop":
    source => "/vagrant/puppet/files/users/dev-user/Desktop/terminator.desktop",
    owner => 'user',
    group => 'user',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/user/Desktop/fedora-gvim.desktop":
    source => "/vagrant/puppet/files/users/dev-user/Desktop/fedora-gvim.desktop",
    owner => 'user',
    group => 'user',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/user/Desktop/Smart-Git.desktop":
    source => "/vagrant/puppet/files/users/dev-user/Desktop/Smart-Git.desktop",
    owner => 'user',
    group => 'user',
    mode   => 744,    # rw-r--r--    
  } ->

  file {
    "/home/user/Desktop/gedit.desktop":
    source => "/vagrant/puppet/files/users/skltp/Desktop/gedit.desktop",
    owner => 'user',
    group => 'user',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/user/Desktop/gnome-terminal.desktop":
    source => "/vagrant/puppet/files/users/skltp/Desktop/gnome-terminal.desktop",
    owner => 'user',
    group => 'user',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/user/Desktop/gnome-nautilus-browser.desktop":
    source => "/vagrant/puppet/files/users/skltp/Desktop/gnome-nautilus-browser.desktop",
    owner => 'user',
    group => 'user',
    mode   => 744,    # rw-r--r--    
  } ->
  file {
    "/home/user/Desktop/mozilla-firefox.desktop":
    source => "/vagrant/puppet/files/users/skltp/Desktop/mozilla-firefox.desktop",
    owner => 'user',
    group => 'user',
    mode   => 744,    # rw-r--r--    
  } ->
  exec { "user-user:set-priv": 
    command => "/bin/chmod g+rx,o+rx /home/user"
    } ->
  exec { "gconftool-2":
    command => "/usr/bin/sudo -u user /usr/bin/gconftool-2 --load /vagrant/puppet/files/users/dev-user/config/gconftool-2/gconftool-2-dump.xml && /usr/bin/sudo touch /var/local/puppet::${title}::gconftool-2.semaphore",
    creates => "/var/local/puppet::${title}::gconftool-2.semaphore"
  } ->
  exec { "git-clone":
    command => "sudo -u user git clone https://github.com/callistaenterprise/cadec-2015-reactive-tutorial.git",
    cwd => "/home/user",
    creates => "/home/user/cadec-2015-reactive-tutorial",
    path => "/usr/bin",
    require => Class['git']
  } ->
  exec { "gradle build eclipse service-provider":
    command => "sudo -u user /home/user/cadec-2015-reactive-tutorial/service-provider/gradlew build eclipse",
    cwd => "/home/user/cadec-2015-reactive-tutorial/service-provider",
    creates => "/home/user/cadec-2015-reactive-tutorial/service-provider/build",
    path => "/usr/bin"
  } ->
  exec { "gradle build eclipse exercises":
    command => "sudo -u user /home/user/cadec-2015-reactive-tutorial/exercises/gradlew build eclipse -x test",
    cwd => "/home/user/cadec-2015-reactive-tutorial/exercises",
    creates => "/home/user/cadec-2015-reactive-tutorial/exercises/build",
    path => "/usr/bin"
  }
}

#
# COPIED FROM DESKTOP.PP, REPLACED /home/skltp with /home/user AND -u skltp WITH -u user
#

class setup {
    # turn of Text Mode setup Utility and NetworkManager
    service { ["firstboot","NetworkManager"]:
         enable => false,
         ensure => "stopped",
    }
    # disable update notification
    file {'/etc/xdg/autostart/gpk-update-icon.desktop':
      ensure => 'absent',
    }
    # enable automatic login
    file {'/etc/gdm/custom.conf':
      source => "/vagrant/puppet/files/cent-os-config/etc/gdm/custom.conf",
      owner => 'root',
      group => 'root',
      mode   => 644,
    }
}



class gdkpixbuf2 {
  case $::osfamily {
    'RedHat': {
      package{'gdk-pixbuf2': ensure => installed }
    }
    default: {
      fail("unsupported osfamily: $::osfamily")
    }
  }
}

class firefox {
  package {
    'firefox':
    ensure => installed,
    require => Class['gdkpixbuf2'] ,
  } ->
  file {
    "/usr/lib/firefox/defaults/preferences/local-settings.js":
    source => "/vagrant/puppet/files/firefox/local-settings.js",
    owner => 'root',
    group => 'root',
    mode   => 644,
  } ->
  file {
    "/usr/lib/firefox/mozilla.cfg":
    source => "/vagrant/puppet/files/users/dev-user/config/firefox/mozilla.cfg",
    owner => 'root',
    group => 'root',
    mode   => 644,
  }
}

class git {
  package{'git': ensure => installed }
}
class gedit {
  package{'gedit': ensure => installed }
}
class emacs {
  package{'emacs': ensure => installed }
}
class terminator {
  package{'terminator': ensure => installed }
}
class gnome-system-monitor {
  package{'gnome-system-monitor': ensure => installed }
}
#define yumgroup($ensure = "present", $optional = false) {
#
#   case $ensure {
#      present,installed: {
#         $pkg_types_arg = $optional ? {
#            true => "--setopt=group_package_types=optional,default,mandatory",
#            default => ""
#         }
#         exec { "Installing $name yum group":
#            command => "/usr/bin/yum -y groupinstall $pkg_types_arg $name",
#            unless => "/usr/bin/yum -y groupinstall $pkg_types_arg $name --downloadonly",
#            timeout => 600,
#         }
#      }
#   }
#}
