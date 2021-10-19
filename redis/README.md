# 说明
redis提供2种部署方式,一种为redis集群模式,一种为redis哨兵模式
redis集群模式最低需要6个副本
redis哨兵模式最低需要3个副本

为了性能考虑,存储使用本地存储。采用rancher提供的插件local-path-storage,基于HostPath使用自动PV.官方文档地址为

https://github.com/rancher/local-path-provisioner
# 安装redis集群
`sh install_redis_cluster.sh`
# 安装redis哨兵
`sh install_redis_sentinel.sh`
# 卸载redis集群
`sh uninstall_redis_cluster.sh`
# 卸载redis哨兵
`sh uninstall_redis_sentinel.sh`
# redis集群自定义配置修改
`vim yaml/redis-cluster/redis-statefulset.yaml`
# redis哨兵自定义配置修改
`vim yaml/redis-sentinel/redis-master-deployment.yaml`
`vim yaml/redis-sentinel/redis-slave-statefulset.yaml`