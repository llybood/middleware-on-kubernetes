kubectl delete -f yaml/rocketmq_v1alpha1_rocketmq_cluster.yaml
cd yaml/rocketmq-operator
sh purge-operator.sh
kubectl delete ns rocketmq


