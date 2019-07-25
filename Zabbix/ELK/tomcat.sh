#! /bin/bash

yum install net-tools
yum install -y tomcat tomcat-webapps
chown -R tomcat:tomcat /var/lib/tomcat
systemctl enable tomcat --now
wget -O /usr/share/tomcat/webapps/sample.war https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war
sudo chmod -R 755 /var/log/tomcat/

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cat << EOF > /etc/yum.repos.d/logstash.repo
[logstash-7.x]
name=Elastic repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

yum install -y logstash
cat << EOF > /etc/logstash/conf.d/agregation.conf
input {
  file {
    path => "/var/log/tomcat/*.log"
    start_position => "beginning"
  }
}
output {
  elasticsearch {
    hosts => ["1.2.3.5:9200"]
  }
  stdout { codec => rubydebug }
}
EOF
systemctl enable logstash.service --now