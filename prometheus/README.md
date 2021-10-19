# 说明
prometheus的部署脚本采用的是官方提供的operator实现,文档地址为

https://github.com/prometheus-operator/kube-prometheus

为了性能考虑,存储使用本地存储。采用rancher提供的插件local-path-storage,基于HostPath使用自动PV.官方文档地址为

https://github.com/rancher/local-path-provisioner
# 安装prometheus
`sh install_prometheus.sh`
# 卸载prometheus
`sh uninstall_prometheus.sh`
# prometheus集群自定义配置修改
`vim yaml/kafka-cluster.yaml`
