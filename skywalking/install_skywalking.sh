kubectl create ns skywalking
# deploy skywalking oap-server
kubectl apply -f yaml/oap-server/rbac.yml
kubectl apply -f yaml/oap-server/deployment.yml
kubectl apply -f yaml/oap-server/service.yml

# deploy skywalking ui
kubectl apply -f yaml/ui/deployment.yml
kubectl apply -f yaml/ui/service.yml
