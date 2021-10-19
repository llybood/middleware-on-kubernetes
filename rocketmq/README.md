# 说明
rocketmq的部署脚本采用的是官方提供的operator实现,文档地址为

https://github.com/apache/rocketmq-operator#quick-start

为了性能考虑,存储使用本地存储。采用rancher提供的插件local-path-storage,基于HostPath使用自动PV.官方文档地址为

https://github.com/rancher/local-path-provisioner
# 安装rocketmq
`sh install_rocketmq_cluster.sh`
# 卸载rocketmq
`sh uninstall_rocketmq_cluster.sh`
# rocketmq集群自定义配置修改
`vim yaml/`

