#!/bin/bash

export TK_HOME="$( cd -P "$( dirname $0 )"/.. && pwd )"
echo -n "Starting Apache Tomcat 6.0.33..."
cd ${TK_HOME}/apache-tomcat-6.0.33/bin
./startup.sh &>/dev/null

if [ $? == 0 ]; then
	echo " done."
fi

exit 0

