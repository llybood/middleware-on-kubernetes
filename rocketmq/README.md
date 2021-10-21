# 说明
rocketmq的部署脚本采用的是官方提供的operator实现,文档地址为

https://github.com/apache/rocketmq-operator#quick-start

为了性能考虑,存储使用本地存储。采用rancher提供的插件local-path-storage,基于HostPath使用自动PV.官方文档地址为

https://github.com/rancher/local-path-provisioner
# rocketmq集群自定义配置修改
`vim yaml/rocketmq_v1alpha1_rocketmq_cluster.yaml`
# 安装rocketmq
`sh install_rocketmq_cluster.sh`
# 卸载rocketmq
`sh uninstall_rocketmq_cluster.sh`
# namesrv地址
namesrv采用的是hostNetwork的网络模式,所以namesrv的地址是所在node节点的ip,端口号为9876
可以通过`kubectl get pods -n rocketmq -o wide| grep name-service`查看

