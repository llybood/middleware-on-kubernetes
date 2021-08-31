# delete skywalking oap-server
kubectl delete -f yaml/oap-server/service.yml
kubectl delete -f yaml/oap-server/deployment.yml
kubectl delete -f yaml/oap-server/rbac.yml

# delete skywalking ui
kubectl delete -f yaml/ui/deployment.yml
kubectl delete -f yaml/ui/service.yml
