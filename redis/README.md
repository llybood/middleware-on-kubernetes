# 说明
redis提供2种部署方式,一种为redis集群模式,一种为redis哨兵模式

redis集群模式最低需要6个副本

redis哨兵模式最低需要3个副本

为了性能考虑,存储使用本地存储。采用rancher提供的插件local-path-storage,基于HostPath使用自动PV.官方文档地址为

https://github.com/rancher/local-path-provisioner
# redis集群模式
## redis集群自定义配置修改
`vim yaml/redis-cluster/redis-statefulset.yaml`
## 安装redis集群
`sh install_redis_cluster.sh`

然后执行`kubectl get pods -n redis`查看pod状态,部署成功后执行

`kubectl exec -it redis-cluster-0 -n redis -- redis-cli --cluster create --cluster-replicas 1 $(kubectl get pods -l app=redis-cluster -o jsonpath='{range.items[*]}{.status.podIP}:6379 {end}' -n redis)`

进行创建集群操作
## 获取服务地址
`kubectl get svc -n redis`
## 卸载redis集群
`sh uninstall_redis_cluster.sh`

redis集群服务地址: redis-cluster.redis:6379
# redis哨兵模式
## redis哨兵自定义配置修改
`vim yaml/redis-sentinel/redis-master-deployment.yaml`

`vim yaml/redis-sentinel/redis-slave-statefulset.yaml`
## 安装redis哨兵
`sh install_redis_sentinel.sh`
## 获取服务地址
`kubectl get svc -n redis`
redis哨兵服务地址: redis-sentinel.redis
## 卸载redis哨兵
`sh uninstall_redis_sentinel.sh`
