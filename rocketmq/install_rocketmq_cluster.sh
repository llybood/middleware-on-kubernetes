# 使用local pv
kubectl apply -f ../storage/local-path-storage.yaml
# 部署rocketmq控制器
sh ./yaml/rocketmq-operator/install-operator.sh
# 部署rocketmq集群(1组broker)
kubectl apply -f rocketmq_v1alpha1_rocketmq_cluster.yaml


