#! /bin/bash
chattr -i /etc/sysconfig/iptables
cp -f /vagrant/files/iptables           /etc/sysconfig/
cp -f /vagrant/files/httpd.conf         /etc/httpd/conf/ 
cp -f /vagrant/files/vhost.conf         /etc/httpd/conf.d/
cp -f /vagrant/files/workers.properties /etc/httpd/conf.d/ 
cp -f /vagrant/files/hosts              /etc/
cp -f /vagrant/files/environment        /etc/
cp -f /vagrant/files/tomcat             /etc/init.d/
cp -f /vagrant/files/.bashrc            /home/tomcat/ 
cp -f /vagrant/files/server.xml         /opt/apache/tomcat/7.0.82/conf/
chkconfig bindserver off
systemctl stop bindserver
update-alternatives --config java <<< 1 > /dev/null
chmod +x /opt/apache/tomcat/7.0.82/bin/catalina.sh
chown -R tomcat:tomcat /opt/apache/tomcat/7.0.82/logs
chkconfig --add tomcat
systemctl enable iptables --now
systemctl enable httpd --now
if [ $(systemctl status tomcat | grep -c "Active: active" ) -eq 0 ]; then systemctl start tomcat; fi

