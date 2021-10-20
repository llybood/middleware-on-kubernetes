# 说明
kafka的部署脚本采用的是strimzi提供的operator实现,文档地址为

https://strimzi.io/quickstarts/

为了性能考虑,存储使用本地存储。采用rancher提供的插件local-path-storage,基于HostPath使用自动PV.官方文档地址为

https://github.com/rancher/local-path-provisioner
# kafka集群自定义配置修改
`vim yaml/kafka-cluster.yaml`
# 安装kafka
`sh install_kafka_cluster.sh`
# 获取服务地址
`kubectl get svc -n kafka`

kafka集群服务地址: kafka-cluster-kafka-bootstrap.kafka:9092
# 收发消息测试
## 发送消息
`kubectl -n kafka run kafka-producer -ti --image=quay.io/strimzi/kafka:0.24.0-kafka-2.8.0 --rm=true --restart=Never -- bin/kafka-console-producer.sh --broker-list kafka-cluster-kafka-bootstrap.kafka:9092 --topic my-topic`
## 接受消息
`kubectl -n kafka run kafka-consumer -ti --image=quay.io/strimzi/kafka:0.24.0-kafka-2.8.0 --rm=true --restart=Never -- bin/kafka-console-consumer.sh --bootstrap-server  kafka-cluster-kafka-bootstrap.kafka:9092 --topic my-topic --from-beginning`
# 卸载kafka
`sh uninstall_kafka_cluster.sh`
