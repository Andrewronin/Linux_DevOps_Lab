#! /bin/bash
#Installing JDK
yum -y -q install java-1.8.0-openjdk-devel
#Installing tomcat
mkdir /opt/tomcat
cd /opt/tomcat
wget http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-8/v8.5.42/bin/apache-tomcat-8.5.42.tar.gz
tar xvzf apache-tomcat-8.5.42.tar.gz
#Copying libraries to resolve internal error
cp /vagrant/gson-2.8.1.jar /opt/tomcat/apache-tomcat-8.5.42/lib/
cp /vagrant/jstl-1.2.jar /opt/tomcat/apache-tomcat-8.5.42/lib/
#Deploying TestApp.war
sudo cp /vagrant/TestApp.war /opt/tomcat/apache-tomcat-8.5.42/webapps/
sudo yum install -y net-tools

sudo export JAVA_OPTS=-Xss1024k
sudo export CATALINA_OPTS=-Xss1024k
	
sudo export JAVA_OPTS="-Dcom.sun.management.jmxremote=true \
                  -Dcom.sun.management.jmxremote.port=9090 \
                  -Dcom.sun.management.jmxremote.ssl=false \
                  -Dcom.sun.management.jmxremote.authenticate=false \
                  -Djava.rmi.server.hostname=192.168.33.10"



#Starting Tomcat to create webapps/TestApp/...
sudo /opt/tomcat/apache-tomcat-8.5.42/bin/startup.sh
sleep 10
#Resolving multipart-config problem
sudo sed -i '/GenericServlet/a \ \ \ \ \ :<multipart-config \/>' /opt/tomcat/apache-tomcat-8.5.42/webapps/TestApp/WEB-INF/web.xml
#Creating custom error page
cat <<EOF >> /opt/tomcat/apache-tomcat-8.5.42/webapps/TestApp/WEB-INF/error.jsp
<html>
 <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>500 error</title>
  </head>
  <body>
    Internal server error!!!
  </body>
</html>
EOF
#Inserting custom error page to config
sudo sed -i "s/<\/web-app>/<error-page>\\n <error-code>500<\/error-code>\\n  <location>\/WEB-INF\/error.jsp<\/location>\\n <\/error-page>\\n<\/web-app>/" /opt/tomcat/apache-tomcat-8.5.42/webapps/TestApp/WEB-INF/web.xml
#Setup up debugging
#export JPDA_ADDRESS=5005
#export JPDA_TRANSPORT=dt_socket
#/opt/tomcat/apache-tomcat-8.5.42/bin/catalina.sh jpda start
##Start debugging and output classes to a file
#echo "classes" | jdb -attach 5005 > /vagrant/result.txt
