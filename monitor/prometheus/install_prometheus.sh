kubectl create -f kube-prometheus/manifests/setup
until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done
kubectl create -f kube-prometheus/manifests/

# 持久化grafana数据
kubectl apply -f patch/grafana-pvc.yaml
#kubectl patch deployment grafana --type='json' -p '[{"op":"replace","path":"/spec/template/spec/volumes/0","value": {"name": "grafana-storage","persistentVolumeClaim": {"claimName": "grafana-data"}}}]' -n monitoring
kubectl patch deployment grafana --type json --patch "$(cat patch/grafana-storage.json)" -n monitoring

# 持久化prometheus数据
kubectl patch prometheus k8s --type json --patch "$(cat patch/prometheus-storage.json)" -n monitoring

# 配置additionalScrapeConfigs
kubectl create secret generic additional-configs --from-file=prometheus-additional.yaml -n monitoring
kubectl patch prometheus k8s --type json --patch "$(cat patch/prometheus-additionalscrapeconfigs.json)" -n monitoring

# 创建service,让外部环境可以访问prometheus和grafana
kubectl apply -f service/alertmanager-svc.yaml
kubectl apply -f service/prometheus-svc.yaml
kubectl apply -f service/grafana-svc.yaml

# 创建kube-scheduler和kube-controller-manager的service,让prometheus可以自动发现服务
kubectl apply -f service/kube-scheduler-svc.yaml
kubectl apply -f service/kube-controller-manager-svc.yaml


