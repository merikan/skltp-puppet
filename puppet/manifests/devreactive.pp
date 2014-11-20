## skall vi verkligen ha denna? Borde paketera en ny base box som är en desktop box istället.

# TODO: 
#
# - Se https://github.com/callistaenterprise/cm-tools/wiki/Exportera-en-rivta-box
#
# - Git Clone
# - Gradle build
# - Eclipse import
# - gconftool-2 ???
# - Shortcuts: Eclipse, SmartGit, Firefox, Emacs, VIM
# - Callista logga

include devreactive

class devreactive {
  include base
  include java8
  include dev-user
  include git
  include firefox
  include gedit
  include emacs
  include gnome-system-monitor
  include gdkpixbuf2
  include eclipse
  include smartgit
  include tomcat

#  include setup ### GÅR INTE ATT STARTA OM BOXEN OM JAG LGER PÅ DETTA!!!
}

class eclipse {
  exec { "eclipse-unpack-dist": 
    command => "/bin/tar -xzf /vagrant/puppet/files/eclipse-java-luna-SR1-linux-gtk.tar.gz -C /home/user",
    user => user,
    creates => "/home/user/eclipse",
  }
}

class smartgit {
  exec { "smartgit-unpack-dist": 
    command => "/bin/tar -xzf /vagrant/puppet/files/smartgit-generic-6_5_0.tar.gz -C /home/user",
    user => user,
    creates => "/home/user/smartgit",
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
  file {
    "/home/user/Pictures/eHalsa_green_white_cmyk-81.png":
    source => "/vagrant/puppet/files/users/skltp/inera-logo.png",
    owner => 'user',
    group => 'user',
    mode   => 644,    # rw-r--r--    
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

# exec { "gconftool-2":
#  command => "/usr/bin/sudo -u user /usr/bin/gconftool-2 --load /vagrant/puppet/files/users/skltp/gconftool-2-dump.xml && /usr/bin/sudo touch /var/local/puppet::${title}::gconftool-2.semaphore",
#  creates => "/var/local/puppet::${title}::gconftool-2.semaphore"
# }


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
    source => "/vagrant/puppet/files/firefox/mozilla.cfg",
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
