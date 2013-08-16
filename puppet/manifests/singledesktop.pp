## skall vi verkligen ha denna? Borde paketera en ny base box som är en desktop box istället.

include singleserver
include setup
include graphical_desktop
include soapui

    class setup {
        # turn of Text Mode setup Utility and NetworkManager
        service { ["firstboot","NetworkManager"]:
             enable => false,
             ensure => "stopped",
             require => Class['graphical_desktop'] 
        } ->
        package {
          'firefox':
          ensure => installed
        }
    }

    class soapui {
      exec { "unpack-soapui" : 
        command => "/bin/tar -zxvf /vagrant/puppet/files/soapui-4.5.2-linux-bin.tar.gz -C /home/skltp",
        creates => "/home/skltp/soapui-4.5.2",
        require => Class['graphical_desktop'] 
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


