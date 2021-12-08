#!/bin/sh 
kubectl create ns loki
kubectl create secret generic loki-config --from-file=config/loki.yaml -n loki
# 部署loki-write
kubectl apply -f yaml/write-cluster/statefulset.yaml -n loki
kubectl apply -f yaml/write-cluster/service.yaml -n loki
# 部署loki-read(querier和query-frontend)
kubectl apply -f yaml/read-cluster/statefulset.yaml -n loki
kubectl apply -f yaml/read-cluster/service.yaml -n loki
# 部署compactor
kubectl apply -f yaml/compactor/deployment.yaml -n loki
# 部署promtail
kubectl create secret generic promtail-config --from-file=config/promtail.yaml -n loki
kubectl apply -f yaml/promtail/rbac.yaml -n loki
kubectl apply -f yaml/promtail/daemonset.yaml -n loki
