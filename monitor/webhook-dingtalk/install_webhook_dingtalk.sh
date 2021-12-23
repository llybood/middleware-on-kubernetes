# 根据配置文件创建configmap 
kubectl create configmap alertmanager-webhook-dingtalk -n monitoring --from-file=config
# 拉起webhook-dingtalk
kubectl apply -f yaml/deployment.yaml
kubectl apply -f yaml/service.yaml
# 修改alertmanager配置
kubectl delete secret alertmanager-main -n monitoring
kubectl create secret generic alertmanager-main --from-file=yaml/alertmanager.yaml -n monitoring
