kubectl delete -f yaml/kafka-cluster.yaml -n kafka
kubectl delete -f yaml/operator/kafka-operator.yaml -n kafka
kubectl delete ns kafka
