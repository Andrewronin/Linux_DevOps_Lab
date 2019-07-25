# docker dind
kubectl apply -f dind.yml
# docker cli
kubectl apply -f docker_cli.yml

# metric-server
git clone https://github.com/kubernetes-incubator/metrics-server.git
cd metrics-server/
kubectl create -f deploy/1.8+/
kubectl patch deployment/metrics-server -n kube-system --patch '{
  "spec": {
    "template": {
      "spec": {
        "containers": [
          {
            "name": "metrics-server", 
            "command":[
              "/metrics-server", 
              "--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname",
              "--kubelet-insecure-tls"
            ]
          }
        ]
      }
    }
  }
}'
cd ..
rm -rf metrics-server/

# kubectl top nodes
# kubectl top pods


#custom ns
kubectl create namespace apavarnitsyn
kubectl config set-context --current --namespace=apavarnitsyn
#guestbook
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-master-deployment.yaml
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-master-service.yaml
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-slave-deployment.yaml
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-slave-service.yaml
kubectl apply -f https://k8s.io/examples/application/guestbook/frontend-deployment.yaml
kubectl apply -f https://k8s.io/examples/application/guestbook/frontend-service.yaml
kubectl patch svc frontend -n guestbook-app --patch '{
  "spec": {
    "type": "LoadBalancer"
  }
}'

#volumes
kubectl apply -f volumes.yml

# curl --unix-socket /tmp/docker.sock -X GET http://docker/images/json
