# 删除configmap
kubectl delete -f yaml/config/ -n test

# 删除初始化数据job
kubectl delete -f yaml/tools/job.yaml -n test

# 删除master
kubectl delete -f yaml/master-server/statefulset.yaml -n test

# 删除worker
kubectl delete -f yaml/worker-server/statefulset.yaml -n test

# 删除api-server
kubectl delete -f yaml/api-server/deployment.yaml -n test

# 删除alert-server
kubectl delete -f yaml/alert-server/deployment.yaml -n test
