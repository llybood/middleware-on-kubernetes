kubectl apply -f yaml/crds
until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done
kubectl apply -f yaml/
kubectl apply -f yaml/service/
