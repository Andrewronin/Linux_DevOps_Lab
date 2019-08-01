
#custom ns
 kubectl create namespace nexus
 kubectl config set-context --current --namespace=nexus
#delete

kubectl delete -f nexus/ingress.yml
kubectl delete -f nexus/service.yml
kubectl delete -f nexus/deployment.yml 
kubectl delete -f nexus/volume.yml

sleep 10
#nexus setup
kubectl apply -f nexus/volume.yml
kubectl apply -f nexus/deployment.yml 
kubectl apply -f nexus/service.yml 
kubectl apply -f nexus/ingress.yml 



