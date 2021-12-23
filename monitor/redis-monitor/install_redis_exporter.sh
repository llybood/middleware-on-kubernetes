#!/bin/bash
# 复制模板生成prometheus的job相关配置文件
cp redis-additional.yaml.template  redis-additional.yaml
# 循环读取Redis列表,生成redis监控配置文件
num=$(cat redis.list | grep -v "实例名称" | wc -l)
lines=0
if [ $num -eq 0 ];then
    echo "未发现redis实例信息,请录入redis实例信息后再执行"
    exit 1
fi
cat redis.list | grep -v "实例名称" | while read line
do
  redis_instance=$(echo $line | awk '{print $1}')
  ip=$(echo $line | awk '{print $2}')
  port=$(echo $line | awk '{print $3}')
  password=$(echo $line | awk '{print $4}')
  url="$ip:$port"
  lines=$(expr $lines + 1)
  # 生成redis-exporter密码文件
  if [ $lines -ne $num ];then
    printf '"%s": "%s",\n' "redis://$url" "$password"
  # 生成监控redis的additional-configs配置文件
  else
    printf '"%s": "%s"\n' "redis://$url" "$password"
    # 该步骤是为了避免redis-exporter启动报错,给其赋予一个redis.addr的变量
    sed "s/\$URL/redis:\/\/$url/" yaml/redis-exporter-deployment.yaml.template > yaml/redis-exporter-deployment.yaml
  fi 
  sed -i "/\$filling_targets/a \ \ \ \ - redis://$url" redis-additional.yaml
done > password-file.json
  sed -i '1i\{' password-file.json
  sed -i '$a\}' password-file.json
# 删除additional的模板文字
sed -i "/\$filling_targets/d" redis-additional.yaml
# 生成redis-exporter的secret
if [ $(kubectl get secret -n monitoring | grep redis-monitor-secret | wc -l) -ne 0 ];then
  echo "当前已经存在redis-monitor-secret,请确认并手动删除后重新执行"
  exit 1
fi
kubectl create secret generic redis-monitor-secret --from-file=password-file.json -n monitoring 
# 获取当前additional-configs配置
if [ $(kubectl get secret additional-configs -n monitoring 2>/dev/null | wc -l) -eq 2 ];then
  kubectl get secret additional-configs -n monitoring -o yaml | grep prometheus-additional.yaml | sed -n '1p' | awk '{print $2}' | base64 --decode > prometheus-additional.yaml
# 判断job_name是否已经存在
  if [ $(cat prometheus-additional.yaml | grep redis_exporter_target | wc -l) -ne 0 ];then
    echo "已经存在相同的job_name,请确认后删除原来的job_name后再执行"
    exit 1
  fi
  kubectl delete secret additional-configs -n monitoring
fi
cat redis-additional.yaml >> prometheus-additional.yaml
kubectl create secret generic additional-configs --from-file=prometheus-additional.yaml -n monitoring
# 部署redis-exporter
kubectl apply -f yaml/redis-exporter-deployment.yaml
kubectl apply -f yaml/redis-exporter-service.yaml
kubectl apply -f yaml/redis-exporter-prometheusRule.yaml
