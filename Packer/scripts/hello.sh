#! /bin/bash

sudo yum install -y maven git
git clone https://github.com/sbeliakou/hello-war.git

cat <<EOT >> hello-war/src/main/resources/build-info.txt
Build time: 11.06.2019
Build Machine Name: CentOS-7.6 
Build User Name: Andrey_Pavarnitsyn
EOT
cd  hello-war/
mvn clean package -DbuildNumber=$BUILD_NUMBER
cp /home/vagrant/hello-war/target/mnt-lab.war /usr/share/tomcat/webapps/
cat <<EOT >> /var/lib/tomcat/webapps/deploy-info.txt 
Deployment time: 11.06.2019 
Deploy User: Andrey_Pavarnitsyn
EOT
echo "war is ready"
