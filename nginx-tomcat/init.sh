#!/bin/bash

/usr/sbin/sshd
source /root/.bashrc
/usr/local/tomcat/apache-tomcat-9.0.38/bin/startup.sh
/usr/local/nginx/sbin/nginx
