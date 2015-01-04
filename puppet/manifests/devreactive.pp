# TODO manual steps before releasing a box: 
#
# - Se https://github.com/callistaenterprise/cm-tools/wiki/Exportera-en-rivta-box
#
# - Säkerställ att Firefox startar med startsidan
#
# - Manuell setup av smart git, tag snapshot i VirtualBox först!
#
#   - I understand + 30 days evluation
#   - Use SmartGit as SSH client
#   - Blank user info
#   - No Git provider
#   - Accept existing git repo
#   - Accept error reporting defaults
#   - Checka ut de tre andra brancherna så att de hämtas hem som lokala brancher
#   - Checka ut master branchen igen
#
# - Manuell Eclipse import + mark use this workspace as the default
#
# TODO to improve the automation:
#
# - Autoinstall virtualbox guest additions: 
#   - https://github.com/dotless-de/vagrant-vbguest
#
# - Automatic Eclipse import
#   - https://github.com/seeq12/eclipse-import-projects-plugin
#   - http://stackoverflow.com/questions/11302297/automate-import-of-java-android-projects-into-eclipse-workspace-through-comman
#
# - Auto login + longer lock time of gui (redan fixat av länken ovan?)
#
# - setup en terminator session med fyra fönster
#   - service provider
#   - exercise x
#   - rtlt
#   - curl
#
# clear ctrl+l alternativ som funkar när java program ör igång?
#
# alt till terminator som är lite smartare, kan hålla en konfig t ex?
#

# iptables
# --------
#
# varför funkar inte http://33.33.33.35:9100 från host?
#
# stäng: 
#   $ sudo service iptables stop
#
# öppna för port:
#   $ sudo iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 9100 -j ACCEPT
#
# spara config:
#   $ sudo iptables-save | sudo tee /etc/sysconfig/iptables
#
# hur tillåta websockets kommunikation på annat sätt än att stänga av iptables???
#



#
# dual core
# git pull * 4
# sudo yum install sysstat
# sar -n DEV 3
#
# sudo yum install tcpdump
#
# installera acrobat reader:
#
# sudo yum localinstall AdbeRdr9.5.5-1_i486linux_enu.rpm
# 
# sudo yum install nspluginwrapper.i686 libcanberra-gtk2.i686 gtk2-engines.i686 PackageKit-gtk-module.i686
#


include devreactive

class devreactive {
  include base
  include timezon-setup
  include acrobat-reader
  include java8
  include git
  include dev-user
  include dev-system
  include firefox
  include terminator
  include gedit
  include emacs
  include gnome-system-monitor
  include sysstat
  include tcpdump
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
  exec { "git-co-1":
    command => "sudo -u user git checkout solution1",
    cwd => "/home/user/cadec-2015-reactive-tutorial",
    path => "/usr/bin"
  } ->
  exec { "git-co-2":
    command => "sudo -u user git checkout solution2-callback",
    cwd => "/home/user/cadec-2015-reactive-tutorial",
    path => "/usr/bin"
  } ->
  exec { "git-co-3":
    command => "sudo -u user git checkout solution2-rx",
    cwd => "/home/user/cadec-2015-reactive-tutorial",
    path => "/usr/bin"
  } ->
  exec { "git-co-4":
    command => "sudo -u user git checkout master",
    cwd => "/home/user/cadec-2015-reactive-tutorial",
    path => "/usr/bin"
  } ->
  exec { "gradle build eclipse service-provider":
    command => "sudo -u user /home/user/cadec-2015-reactive-tutorial/service-provider/gradlew build eclipse",
    cwd => "/home/user/cadec-2015-reactive-tutorial/service-provider",
    creates => "/home/user/cadec-2015-reactive-tutorial/service-provider/build",
    path => "/usr/bin",
    timeout => 0
  } ->
  exec { "gradle build eclipse exercises":
    command => "sudo -u user /home/user/cadec-2015-reactive-tutorial/exercises/gradlew build eclipse -x test",
    cwd => "/home/user/cadec-2015-reactive-tutorial/exercises",
    creates => "/home/user/cadec-2015-reactive-tutorial/exercises/build",
    path => "/usr/bin",
    timeout => 0
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
class sysstat {
  package{'sysstat': ensure => installed }
}
class tcpdump {
  package{'tcpdump': ensure => installed }
}
class acrobat-reader {
  exec { "ar-1":
    command => "sudo yum -y localinstall /vagrant/puppet/binaries/dev-box/AdbeRdr9.5.5-1_i486linux_enu.rpm",
    creates => "/opt/Adobe/Reader9/",
    path => "/usr/bin"
  } ->
  exec { "ar-2":
    command => "sudo yum -y install nspluginwrapper.i686 libcanberra-gtk2.i686 gtk2-engines.i686 PackageKit-gtk-module.i686",
    path => "/usr/bin"
  }
}
class timezon-setup {
  exec { "tz-1":
    command => "sudo mv /etc/localtime /etc/localtime.bak",
    creates => "/etc/localtime.bak",
    path => "/usr/bin"
  } ->
  exec { "tz-2":
    command => "sudo ln -s /usr/share/zoneinfo/Europe/Stockholm /etc/localtime",

    path => "/usr/bin"
  }
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
