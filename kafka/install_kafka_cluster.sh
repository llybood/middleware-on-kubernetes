kubectl create ns kafka
kubectl apply -f ../storage/local-path-storage.yaml
kubectl apply -f yaml/operator/kafka-operator.yaml -n kafka
kubectl apply -f yaml/kafka-cluster.yaml -n kafka
