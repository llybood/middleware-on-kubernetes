# 说明
elasticsearch的部署脚本采用的是官方提供的operator实现,官方文档地址为

https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-eck.html

为了性能考虑,存储使用本地存储。采用rancher提供的插件local-path-storage,基于HostPath使用自动PV.官方文档地址为

https://github.com/rancher/local-path-provisioner
# elasticsearch集群自定义配置修改
`vim yaml/elasticsearch-cluster.yml`
# 安装elasticsearch
`sh install_es_cluster.sh`
# 获取部署后的elastic用户密码
`sh get_password.sh`
# 获取服务地址
`kubectl get svc -n elastic-system`

ES服务地址: elasticsearch-es-http.elastic-system:9200

Kibana以NodePort形式对外暴露,地址为: http:/NodeIp:32423
# 卸载elasticsearch
`sh uninstall_es_cluster.sh`




