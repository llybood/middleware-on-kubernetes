kubectl apply -f ../storage/local-path-storage.yaml
kubectl apply -f yaml/operator/crds.yaml
kubectl apply -f yaml/operator/operator.yaml
kubectl apply -f yaml/elasticsearch-cluster.yml -n elastic-system
kubectl apply -f yaml/kibana.yml -n elastic-system
