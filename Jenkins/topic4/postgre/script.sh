kubectl apply -f volume.yml --namespace=jenkins
kubectl apply -f deployment.yml --namespace=jenkins
kubectl apply -f service.yml --namespace=jenkins

kubectl delete -f service.yml --namespace=jenkins
kubectl delete -f deployment.yml --namespace=jenkins
kubectl delete -f volume.yml --namespace=jenkins
kubectl delete -f configmap.yml --namespace=jenkins





