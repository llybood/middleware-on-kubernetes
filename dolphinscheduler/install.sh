#!/bin/bash
namespace="dolphinscheduler"

# 创建namespace
kubectl create namespace dolphinscheduler

# 创建rbac
kubectl apply -f yaml/rbac.yaml -n $namespace

# 创建configmap
kubectl apply -f yaml/config/ -n $namespace

# 初始化数据
kubectl apply -f yaml/tools/job.yaml -n $namespace
until kubectl get pods -n $namespace | grep db-init-job | grep Completed; do date; sleep 5; echo "正在初始化数据"; done

# 部署master
kubectl apply -f yaml/master-server/statefulset.yaml -n $namespace

# 部署worker
kubectl apply -f yaml/worker-server/statefulset.yaml -n $namespace

# 部署api-server
kubectl apply -f yaml/api-server/deployment.yaml -n $namespace

# 部署alert-server
kubectl apply -f yaml/alert-server/deployment.yaml -n $namespace

# 部署service
kubectl apply -f yaml/service/clusterip.yaml -n $namespace
