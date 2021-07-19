kubectl apply -f yaml/mysql-configmap.yaml -n mysql
kubectl apply -f yaml/mysql-svc.yaml -n mysql
kubectl apply -f yaml/mysql-statefulset.yaml -n mysql
