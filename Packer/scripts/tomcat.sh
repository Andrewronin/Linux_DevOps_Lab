#! /bin/bash

sudo yum install -y tomcat
sudo chown -R tomcat:tomcat /var/lib/tomcat
systemctl enable tomcat --now
echo "tomcat is READY"
