| 监控维度 | alert名称 | 表达式| 持续时间 | 监控说明|
| :----| :----| :---- | :---- | :---- |
|主机状态|NodeDown| up{job="node-exporter"} == 0 | 1m | 主机是否启动|
|主机CPU|NodeCpuUsageHigh|(1 - avg by (instance) (irate(node_cpu_seconds_total{job="node-exporter",mode="idle"}[5m]))) * 100 > 80|5m|CPU使用率超过80%|
|主机CPU|NodeCpuStealHigh|avg by(instance) (rate(node_cpu_seconds_total{job="node-exporter",mode="steal"}[5m])) * 100 > 10|5m|steal使用率大于10%,可能会存在资源争抢|
|主机内存|
|主机磁盘|
|主机网络|
