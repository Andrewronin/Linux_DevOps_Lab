#! /bin/bash

yum install -y net-tools
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cat << EOF > /etc/yum.repos.d/elasticsearch.repo
[elasticsearch-7.x]
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

yum install -y elasticsearch 
echo "network.host: 1.2.3.5" >> /etc/elasticsearch/elasticsearch.yml
echo "discovery.type: single-node" >> /etc/elasticsearch/elasticsearch.yml
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.2.0-x86_64.rpm

systemctl enable elasticsearch.service --now
cat << EOF > /etc/yum.repos.d/kibana.repo
[kibana-7.x]
name=Kibana repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF
yum install -y kibana
echo 'server.host: "1.2.3.5"' >> /etc/kibana/kibana.yml
echo 'elasticsearch.hosts: ["http://1.2.3.5:9200"]' >> /etc/kibana/kibana.yml
systemctl enable kibana.service --now