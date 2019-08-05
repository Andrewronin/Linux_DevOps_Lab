
#passwd
kubectl apply -f password.yml --namespace=jenkins

#postgre
kubectl apply -f postgre/volume.yml --namespace=jenkins
#kubectl apply -f postgre/configmap.yml --namespace=jenkins
kubectl apply -f postgre/deployment.yml --namespace=jenkins
kubectl apply -f postgre/service.yml --namespace=jenkins

#Sonar
kubectl apply -f sonarqube/volumes.yml --namespace=jenkins
kubectl apply -f sonarqube/deployment.yml --namespace=jenkins
kubectl apply -f sonarqube/service.yml --namespace=jenkins
kubectl apply -f sonarqube/ingress.yml --namespace=jenkins


# kubectl delete -f sonarqube/ingress.yml --namespace=jenkins
# kubectl delete -f sonarqube/service.yml --namespace=jenkins
# kubectl delete -f sonarqube/deployment.yml --namespace=jenkins
# kubectl delete -f sonarqube/volumes.yml --namespace=jenkins

# kubectl delete -f postgre/service.yml --namespace=jenkins
# kubectl delete -f postgre/deployment.yml --namespace=jenkins
# kubectl delete -f postgre/volume.yml --namespace=jenkins




