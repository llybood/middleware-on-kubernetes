PASSWORD=$(kubectl get secret elasticsearch-es-elastic-user -n elastic-system -o=jsonpath='{.data.elastic}' | base64 --decode; echo)
USER="elastic"
echo -e "user:elastic\npassword:$PASSWORD"
