# 说明
zookeeper的部署采用的是statefulset+headlesss实现


为了性能考虑,存储使用本地存储。采用rancher提供的插件local-path-storage,基于HostPath使用自动PV.官方文档地址为

https://github.com/rancher/local-path-provisioner
# 安装zookeeper
`sh install_zookeeper_cluster.sh`
# zookee集群自定义配置修改
`vim yaml/zk-statefulset.yaml`
# 获取服务地址
`kubectl get svc -n redis`

zk集群服务地址: zk-hs.zookeeper:2181
# 卸载zookeeper
`sh uninstall_zookeeper_cluster.sh`


