
#!/bin/bash
#
# tomcat 7
#
# chkconfig: 2345 80 20 
# description: Start Tomcat 7 daemon
# processname: tomcat7   


# Source function library.
. /etc/init.d/functions


RETVAL=$?
APP_NAME="Tomcat"
#APP_HOME="<%#= @tomcat::params::tomcat_home %>"
APP_HOME="/opt/tomcat-7.0.35"
RUN_AS_USER="tomcat"


case "$1" in
 start)
       echo $"Starting $APP_NAME"
            /bin/su -s /bin/sh $RUN_AS_USER $APP_HOME/bin/startup.sh
    ;;
 stop)
      echo $"Stopping $APP_NAME"
            /bin/su -s /bin/sh $RUN_AS_USER $APP_HOME/bin/shutdown.sh
    ;;
 restart)
      echo $"Restarting $(APP_NAME)"
      $0 stop
      $0 start
    ;;
 version)
      if [ -f $APP_HOME/bin/version.sh ];
        then
        echo "Display $APP_NAME Version"
        /bin/su -s /bin/sh $RUN_AS_USER -c $APP_HOME/bin/version.sh
        RETVAL=$?
      fi
      ;;
 *)
    echo $"Usage: $0 {start|stop|restart|version}"
    exit 1
    ;;
esac


exit $RETVAL