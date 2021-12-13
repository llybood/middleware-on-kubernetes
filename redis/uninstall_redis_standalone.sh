kubectl delete -f yaml/redis-standalone/redis-deployment.yaml -n redis
kubectl delete -f yaml/redis-standalone/redis-svc.yaml -n redis
kubectl delete ns redis
