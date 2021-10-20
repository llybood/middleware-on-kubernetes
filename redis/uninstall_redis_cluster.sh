kubectl delete -f yaml/redis-cluster/redis-svc.yaml -n redis
kubectl delete -f yaml/redis-cluster/redis-statefulset.yaml -n redis
kubectl delete ns redis
