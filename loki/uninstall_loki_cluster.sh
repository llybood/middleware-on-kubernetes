#!/bin/sh 
kubectl delete -f yaml/read-cluster/statefulset.yaml -n loki
kubectl delete -f yaml/read-cluster/service.yaml -n loki
kubectl delete -f yaml/write-cluster/statefulset.yaml -n loki
kubectl delete -f yaml/write-cluster/service.yaml -n loki
kubectl delete secret loki-config -n loki 
kubectl delete secret promtail-config -n loki
kubectl delete -f yaml/promtail/daemonset.yaml -n loki
kubectl delete -f yaml/promtail/rbac.yaml -n loki
