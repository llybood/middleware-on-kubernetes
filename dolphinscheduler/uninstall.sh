#!/bin/bash
namespace="dolphinscheduler"

# 删除rbac
kubectl delete -f yaml/rbac.yaml -n $namespace
# 删除configmap
kubectl delete -f yaml/config/ -n $namespace

# 删除初始化数据job
kubectl delete -f yaml/tools/job.yaml -n $namespace

# 删除master
kubectl delete -f yaml/master-server/statefulset.yaml -n $namespace

# 删除worker
kubectl delete -f yaml/worker-server/statefulset.yaml -n $namespace

# 删除api-server
kubectl delete -f yaml/api-server/deployment.yaml -n $namespace

# 删除alert-server
kubectl delete -f yaml/alert-server/deployment.yaml -n $namespace

# 删除service
kubectl delete -f yaml/service/clusterip.yaml -n $namespace

# 删除namespace
kubectl delete namespace $namespace
