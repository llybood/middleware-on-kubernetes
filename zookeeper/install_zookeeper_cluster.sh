kubectl apply -f yaml/namespace.yaml
kubectl apply -f yaml/local-path-storage.yaml
kubectl apply -f yaml/headless-service.yaml
kubectl apply -f yaml/poddisruptionbudget.yaml
kubectl apply -f yaml/zk-statefulset.yaml

