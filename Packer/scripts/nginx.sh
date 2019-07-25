#! /bin/bash

sudo yum install -y nginx
sed -e '/root/s/^/#/' -i /etc/nginx/nginx.conf
echo "return 301 http://5.12.19.89:8080/mnt-lab/;" > /etc/nginx/default.d/vhost.conf
systemctl enable nginx --now
echo "nginx is READY"
