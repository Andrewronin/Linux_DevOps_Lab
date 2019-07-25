WEBAPPS="/opt/tomcat/current/webapps"

if [ $(rpm -qa | grep -c "jdk-12.0.1") -eq 0 ]; then
#if [ $(rpm -qa | grep -c "java-1.8.0") -eq 0 ]; then
    # Ustanoŭka "java-1.8.0-openjdk"
    #yum install -y java-1.8.0-openjdk-devel
    wget -q --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/12.0.1+12/69cfe15208a647278a19ef0990eea691/jdk-12.0.1_linux-x64_bin.rpm
    rpm -i jdk-12.0.1_linux-x64_bin.rpm 
fi

if [ ! -d /opt/tomcat ]; then
# Padrychtoŭka asiaroddzia da ŭstanoŭki "tomcat 8.5"
    mkdir /opt/tomcat/
    useradd -M -U -d /opt/tomcat -s /bin/nologin tomcat


# Ustanoŭka "tomcat 8.5"
    wget -cq "http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-8/v8.5.42/bin/apache-tomcat-8.5.42.tar.gz" -P /tmp
    tar -xf /tmp/apache-tomcat-8.5.42.tar.gz -C /opt/tomcat/
    ln -s /opt/tomcat/apache-tomcat-8.5.42 /opt/tomcat/current
    chown -R tomcat:tomcat /opt/tomcat
fi

if [ ! -f /etc/systemd/system/tomcat.service ]; then
# Stvareńnie "tomcat.service" dla "systemd"
    cat > /etc/systemd/system/tomcat.service <<EOF
[Unit]
Description=Tomcat 8.5 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="CATALINA_BASE=/opt/tomcat/current"
Environment="CATALINA_HOME=/opt/tomcat/current"
Environment="CATALINA_PID=/opt/tomcat/current/temp/tomcat.pid"

ExecStart=/opt/tomcat/current/bin/startup.sh
ExecStop=/opt/tomcat/current/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF
    systemctl daemon-reload
    systemctl enable tomcat
fi

# Razhortvańnie TestApp.war
if [ ! -d "$WEBAPPS"/TestApp ]; then
    mkdir "$WEBAPPS"/TestApp
    (cd "$WEBAPPS"/TestApp && jar -xf /vagrant/TestApp.war)

    chown -R tomcat:tomcat /opt/tomcat/
fi

if [ ! -f /home/vagrant/jstatd.all.policy ]; then
    cat > /home/vagrant/jstatd.all.policy <<EOF
grant codebase "file:\${java.home}/../lib/tools.jar" {
   permission java.security.AllPermission;
};
EOF



fi
if [ ! -f /opt/tomcat/current/bin/setenv.sh ]; then
cat > /opt/tomcat/current/bin/setenv.sh <<EOF
export JAVA_OPTS="-Dcom.sun.management.jmxremote=true \
                  -Dcom.sun.management.jmxremote.port=9090 \
                  -Dcom.sun.management.jmxremote.ssl=false \
                  -Dcom.sun.management.jmxremote.authenticate=false \
                  -Djava.rmi.server.hostname=172.31.31.254 \
                  -Xverify:none \
                  -Xss1024k"
EOF
fi

if [ $(systemctl status tomcat | grep -c "Active: active") -eq 0 ]; then
    systemctl start tomcat
fi

# jstatd -J-Djava.security.policy=jstatd.all.policy -J-Djava.rmi.server.hostname=172.31.31.254
