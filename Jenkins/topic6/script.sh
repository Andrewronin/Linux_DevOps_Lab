#! /bin/bash

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl


TEST=$(/var/jenkins_home/workspace/Apavarnitsyn-CD-Kubectl/kubectl get pods) 
if [ $(echo "$TEST" | grep -c 'tomcat-blue') -lt 1 ]
	then 
    echo "BLUE install"
    ./kubectl apply -f blue/deployment.yml
    ./kubectl apply -f blue/service.yml
    echo "sleep"
    sleep 30
    TEST_CURL=$(curl -IL 192.168.56.244:8080/hello/)

    if [ $(echo "$TEST_CURL" | grep -c 'HTTP/1.1 200') -gt 0 ]
    then
    	curl -IL 192.168.56.243:8080/hello/
    	./kubectl apply -f blue/ingress.yml
    	echo "Everything is OK. Clean up"
    	./kubectl delete -f green/deployment.yml
        ./kubectl delete -f green/service.yml 
        echo "Tomcat BLUE installed succesfully"   	
    else
    	echo "ALARM! Traceback!"
    	./kubectl delete -f blue/deployment.yml
        ./kubectl delete -f blue/service.yml
    fi    
else
	echo "GREEN install"
    ./kubectl apply -f green/deployment.yml
    ./kubectl apply -f green/service.yml
    echo "sleep"
    sleep 30
    TEST_CURL=$(curl -IL 192.168.56.245:8080/hello/)

    
    if [ $(echo "$TEST_CURL" | grep -c 'HTTP/1.1 200') -gt 0 ]
    then
    	curl -IL 192.168.56.244:8080/hello/
    	./kubectl apply -f green/ingress.yml
    	echo "Everything is OK. Clean up"
    	./kubectl delete -f blue/deployment.yml
        ./kubectl delete -f blue/service.yml  
        echo "Tomcat GREEN installed succesfully"   

    else
    	echo "ALARM! Traceback!"
    	./kubectl delete -f green/deployment.yml
        ./kubectl delete -f green/service.yml
    fi
fi

   ./kubectl delete -f green/deployment.yml --namespace=jenkins
   ./kubectl delete -f green/service.yml --namespace=jenkins
   ./kubectl delete -f blue/deployment.yml --namespace=jenkins
   ./kubectl delete -f blue/service.yml   --namespace=jenkins