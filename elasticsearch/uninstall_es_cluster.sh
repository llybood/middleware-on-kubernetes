kubectl delete -f yaml/kibana.yml -n elastic-system
kubectl delete -f yaml/elasticsearch-cluster.yml -n elastic-system
kubectl delete -f yaml/operator/crds.yaml
kubectl delete -f yaml/operator/operator.yaml
