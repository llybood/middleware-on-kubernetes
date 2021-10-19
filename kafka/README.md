# 说明
kafka的部署脚本采用的是strimzi提供的operator实现,文档地址为

https://strimzi.io/quickstarts/

为了性能考虑,存储使用本地存储。采用rancher提供的插件local-path-storage,基于HostPath使用自动PV.官方文档地址为

https://github.com/rancher/local-path-provisioner
# 安装kafka
`sh install_kafka_cluster.sh`
# 卸载elasticsearch
`sh uninstall_kafka_cluster.sh`
# kafka集群自定义配置修改
`vim yaml/kafka-cluster.yaml`
