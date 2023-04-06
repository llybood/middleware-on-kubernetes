# 创建configmap
kubectl apply -f yaml/config/ -n test

# 初始化数据
kubectl apply -f yaml/tools/job.yaml -n test
until kubectl get pods -n test | grep db-init-job | grep Completed; do date; sleep 5; echo "正在初始化数据"; done

# 部署master
kubectl apply -f yaml/master-server/statefulset.yaml -n test

# 部署worker
kubectl apply -f yaml/worker-server/statefulset.yaml -n test

# 部署api-server
kubectl apply -f yaml/api-server/deployment.yaml -n test

# 部署alert-server
kubectl apply -f yaml/alert-server/deployment.yaml -n test
