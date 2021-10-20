kubectl delete -f yaml/mysql-configmap.yaml -n mysql
kubectl delete -f yaml/mysql-svc.yaml -n mysql
kubectl delete -f yaml/mysql-statefulset.yaml -n mysql
kubectl delete ns mysql
