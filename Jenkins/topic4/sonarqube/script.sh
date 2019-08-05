kubectl apply -f volumes.yml --namespace=jenkins
kubectl apply -f deployment.yml --namespace=jenkins
kubectl apply -f service.yml --namespace=jenkins
kubectl apply -f ingress.yml --namespace=jenkins

kubectl delete -f ingress.yml --namespace=jenkins
kubectl delete -f service.yml --namespace=jenkins
kubectl delete -f deployment.yml --namespace=jenkins
kubectl delete -f volumes.yml --namespace=jenkins






