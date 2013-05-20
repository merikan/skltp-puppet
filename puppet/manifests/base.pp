class base {
  include unzip
  include vim
}

class unzip {
  package{'unzip': ensure => installed }
}

class vim {
  case $::osfamily {
    'RedHat': {
      $vim_package = ["vim-X11", "vim-enhanced"]
    }
    'Debian': {
      $vim_package = ["vim-gnome", "vim"]
    }
    default: {
      fail("unsupported osfamily: $::osfamily")
    }
  }

  package{$vim_package: ensure => installed }

}

  define replace($file, $pattern, $replacement) {
    exec { "/usr/bin/perl -pi -e 's/$pattern/$replacement/' '$file'":
       onlyif => "/usr/bin/perl -ne 'BEGIN { \$ret = 1; } \$ret = 0 if /$pattern/ && ! /$replacement/ ; END { exit \$ret; }' '$file'",
  }
}