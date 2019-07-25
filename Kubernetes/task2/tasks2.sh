#author
kubectl apply -f author/service_author.yml 
kubectl apply -f author/author_deployment.yml

#flask
kubectl apply -f flask/flask_deployment.yml 
kubectl apply -f flask/service_flask.yml

#Final loadbalancer
kubectl apply -f ingress/ingress.yml 
kubectl apply -f ingress/guest_ingress.yml

#configMap+secret
kubectl apply -f configMap.yml

#dashboard

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl patch svc kubernetes-dashboard -n kube-system --patch '{
  "spec": {
    "type": "NodePort"
  }
}'

# service account
cat << EOF | kubectl apply -f -
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
EOF
# token
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')

