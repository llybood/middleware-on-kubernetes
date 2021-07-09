kubectl apply -f kafka-operator.yaml -n kafka
kubectl apply -f local-path-storage.yaml
kubectl apply -f kafka-cluster.yaml -n kafka
