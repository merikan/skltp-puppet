
define replace($file, $pattern, $replacement) {
  exec { "/usr/bin/perl -pi -e 's/$pattern/$replacement/' '$file'":
      onlyif => "/usr/bin/perl -ne 'BEGIN { \$ret = 1; } \$ret = 0 if /$pattern/ && ! /$replacement/ ; END { exit \$ret; }' '$file'",
   }
}


# Java package
# $java::params::package_name = 'jdk-7-linux-x64.rpm'
include java

# Tomcat package
include tomcat

# Mule package
include mule 
