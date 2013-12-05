## skall vi verkligen ha denna? Borde paketera en ny base box som är en desktop box istället.

include singleserver
include setup
include firefox
include graphical_desktop
include soapui
include gedit

    class setup {
        # turn of Text Mode setup Utility and NetworkManager
        service { ["firstboot","NetworkManager"]:
             enable => false,
             ensure => "stopped",
             require => Class['graphical_desktop'] 
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


