class base {
  include unzip
  include vim
  include lsof
  include tree
  include telnet
  include keyboard
  #include iptables::disable
}

class unzip {
  package{'unzip': ensure => installed }
}

class vim {
  case $::osfamily {
    default: {fail("unsupported osfamily: $::osfamily")}
    'RedHat': {
      $vim_package = ["vim-X11", "vim-enhanced"]
    }
    'Debian': {
      #$vim_package = ["vim-gnome", "vim"]
      $vim_package = ["vim"]
    }
  }

  package{$vim_package: ensure => installed }

}

class lsof {
  package{'lsof': ensure => installed }
}

class tree {
  package{'tree': ensure => installed }
}

class telnet {
  package{'telnet': ensure => installed }
}

class keyboard {
  if $::osfamily == 'RedHat' {
    file {
      "/etc/sysconfig/keyboard":
      source => "/vagrant/puppet/files/cent-os-config/etc/sysconfig/keyboard",
      owner => 'root',
      group => 'root',
      mode   => 644,    # rw-r--r--    
    }
  }
}

define replace($file, $pattern, $replacement) {
  exec { "/usr/bin/perl -pi -e 's/$pattern/$replacement/' '$file'":
    onlyif => "/usr/bin/perl -ne 'BEGIN { \$ret = 1; } \$ret = 0 if /$pattern/ && ! /$replacement/ ; END { exit \$ret; }' '$file'",
  }
}