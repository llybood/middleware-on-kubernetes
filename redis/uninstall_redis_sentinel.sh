kubectl delete -f yaml/redis-sentinel/redis-configmap.yaml -n redis
kubectl delete -f yaml/redis-sentinel/redis-master-svc.yaml -n redis
kubectl delete -f yaml/redis-sentinel/redis-sentinel-svc.yaml -n redis
kubectl delete -f yaml/redis-sentinel/redis-master-deployment.yaml -n redis
kubectl delete -f yaml/redis-sentinel/redis-slave-statefulset.yaml -n redis
kubectl delete ns redis
