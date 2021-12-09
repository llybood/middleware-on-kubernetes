# 说明
Loki集群部署参考的是官方文档给出的Simple scalable deployment mode架构,三个write实例,2个read实例。如下图所示
![image](https://user-images.githubusercontent.com/8406610/145349714-8ee2fe3b-60c2-48cf-8c2a-a55f0868a28b.png)<br>
关于该架构的详细描述见[Simple scalable deployment mode](https://grafana.com/docs/loki/latest/fundamentals/architecture/#simple-scalable-deployment-mode)
<br>
但是在实际部署的时候发现,Loki加上"--target=read"参数启动read实例的时候,会启动compactor模块,和官方的配置描述[Supported contents and default values of](https://grafana.com/docs/loki/latest/configuration/#supported-contents-and-default-values-of-lokiyaml)有出入,但是根据[Compactor](https://grafana.com/docs/loki/latest/operations/storage/boltdb-shipper/#compactor)的说明,
compactor实例建议只启动一个,启动多个compactor实例,可能数据有丢失的风险,所以我们单独部署一个compactor副本。因此我们集群各个实例的启动参数分别为
* read实例启动的参数为"--target=querier,query-frontend"
* write实例启动的参数为"--target=write"
* compactor实例启动的参数为"--target=compactor"

write实例和read实例,compactor实例都需要持久化存储,为了性能考虑,存储使用本地存储。采用rancher提供的插件local-path-storage,基于HostPath使用自动PV.官方文档地址为
https://github.com/rancher/local-path-provisioner<br>
后端使用支持S3协议的OSS对象存储存储chunk和index,亲测可以使用

# Loki集群配置修改
`vim config/loki.yaml`
# promatail采集配置修改
`vim config/promtail.yaml`
# 获取服务地址
`kubectl get svc -n loki`

Loki集群前端地址(对接grafana): http://loki-frontend.loki:3100
