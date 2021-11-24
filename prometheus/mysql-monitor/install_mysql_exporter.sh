#!/bin/bash

#生成serviceMontor的endpoint
generate_serviceMonitor() {
  mysql_instance=$1
  url=$2
  cat << EOF 
  - interval: 15s
    port: $mysql_instance-mysql-monitor-port
    targetPort: 9104
    relabelings:
      - targetLabel: instance
        replacement: $mysql_instance-$url
EOF
}

#循环读取数据库列表,启动mysql-exporter容器
cat mysql.list | while read line
do
  mysql_instance=$(echo $line | awk '{print $1}')
  ip=$(echo $line | awk '{print $2}')
  port=$(echo $line | awk '{print $3}')
  username=$(echo $line | awk '{print $4}')
  password=$(echo $line | awk '{print $5}')
  url="$ip:$port"
  kubectl create secret generic $mysql_instance-mysql-secret --from-literal=url=$url --from-literal=username=$username --from-literal=password=$password -n monitoring
  sed "s/\${mysql-instance}/$mysql_instance/g" yaml/mysql-exporter-deployment.yaml | kubectl apply -f -
  sed "s/\${mysql-instance}/$mysql_instance/g" yaml/mysql-exporter-service.yaml | kubectl apply -f -
  #kubectl apply -f yaml/mysql-exporter-serviceMonitor.yaml
  generate_serviceMonitor $mysql_instance $url >> mysql-serviceMonitor_tmp.yaml
done
#注入serviceMontor对象
sed '10r mysql-serviceMonitor_tmp.yaml' yaml/mysql-exporter-serviceMonitor.yaml | kubectl apply -f -
if [ $? -eq 0 ];then
  rm -f mysql-serviceMonitor_tmp.yaml
fi

