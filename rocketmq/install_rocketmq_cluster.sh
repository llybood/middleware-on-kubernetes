# 使用local pv
kubeclt apply -f rocketmq-storage.yaml
# 部署rocketmq控制器
sh ./rocketmq-operator/install-operator.sh
# 部署rocketmq集群(1组broker)
kubectl apply -f rocketmq_v1alpha1_rocketmq_cluster.yaml


