## skall vi verkligen ha denna? Borde paketera en ny base box som är en desktop box istället.

include singleserver
include setup
include firefox
include graphical_desktop
include soapui
include gdkpixbuf2
include gedit
include emacs
include gnome-system-monitor

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
        command => "/bin/tar -zxvf /vagrant/puppet/binaries/rivta-box/SoapUI-5.0.0-linux-bin.tar.gz -C /home/skltp",
        creates => "/home/skltp/SoapUI-5.0.0",
        user => 'skltp',
        require => Class['graphical_desktop'], 
      }
    }
    file {
      'users:skltp:skltp-soapui-project.xml':
        path => "/home/skltp/skltp-soapui-project.xml",
        ensure  => file,
        source => "/vagrant/puppet/modules/soapui/files/skltp-soapui-project.xml",
        owner => skltp,
        group => skltp;
      'users:skltp:client.jks':
        path => "/home/skltp/client.jks",
        source => "/vagrant/puppet/modules/soapui/files/client.jks",
        owner => 'skltp',
        group => 'skltp';
      'users:skltp:soapui32.png':
        path => "/home/skltp/Pictures/soapui32.png",
        source => "/vagrant/puppet/modules/soapui/files/soapui32.png",
        owner => 'skltp',
        group => 'skltp';
      'users:skltp:soapui-settings.xml':
        path => "/home/skltp/soapui-settings.xml",
        ensure  => file,
        source => "/vagrant/puppet/modules/soapui/files/soapui-settings.xml",
        owner => skltp,
        group => skltp,
        require => Class['soapui'];
      'users:skltp:default-soapui-workspace.xml':
        path => "/home/skltp/default-soapui-workspace.xml",
        ensure  => file,
        source => "/vagrant/puppet/modules/soapui/files/default-soapui-workspace.xml",
        owner => skltp,
        group => skltp,
        require => Class['soapui'];
    } ->
    exec { "gconftool-2":
      command => "/usr/bin/sudo -u skltp /usr/bin/gconftool-2 --load /vagrant/puppet/files/users/skltp/gconftool-2-dump.xml && /usr/bin/sudo touch /var/local/puppet::${title}::gconftool-2.semaphore",
      creates => "/var/local/puppet::${title}::gconftool-2.semaphore"
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

    class graphical_desktop {
      #case $::osfamily {
      #  'RedHat': {
      #    yumgroup { 'basic-desktop': }
      #    yumgroup { 'desktop-platform': }
      #    yumgroup { 'x11': }
      #    yumgroup { 'fonts': }
      #  }
      #  default: {
      #    fail("unsupported osfamily: $::osfamily")
      #  }
      #}
      #replace {"autostart of graphical login":
      #  file => "/etc/inittab",
      #  pattern => "id:3:initdefault:",
      #  replacement => 'id:5:initdefault:',
      #}
    }

    class gdkpixbuf2 {
      case $::osfamily {
        'RedHat': {
          package{'gdk-pixbuf2': ensure => installed }        }
        default: {
          fail("unsupported osfamily: $::osfamily")
        }
      }
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


