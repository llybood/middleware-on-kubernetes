# 说明
mysql集群的部署架构为一主两从,部署脚本为参考k8s官方文档提供的示例实现,地址为

https://kubernetes.io/zh/docs/tasks/run-application/run-replicated-stateful-application/

为了性能考虑,存储使用本地存储。采用rancher提供的插件local-path-storage,基于HostPath使用自动PV.官方文档地址为

https://github.com/rancher/local-path-provisioner
# 安装mysql集群
`sh install_mysql_cluster.sh`
# 卸载mysql集群
`sh uninstall_mysql_cluster.sh`
# mysql集群自定义配置修改
`vim yaml/mysql-statefulset.yaml`
