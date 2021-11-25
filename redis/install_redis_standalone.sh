kubectl create ns redis
kubectl apply -f yaml/redis-standalone/redis-deployment.yaml -n redis
kubectl apply -f yaml/redis-standalone/redis-svc.yaml -n redis
#kubectl exec -it redis-cluster-0 -n redis -- redis-cli --cluster create --cluster-replicas 1 $(kubectl get pods -l app=redis-cluster -o jsonpath='{range.items[*]}{.status.podIP}:6379 {end}' -n redis)
