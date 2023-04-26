#!/bin/python3

import os
import json
import sys
import requests

master_list = ['xxx.xxx.xxx.xxx', 'xxx.xxx.xxx.xxx']
worker_list = ['xxx.xxx.xxx.xxx', 'xxx.xxx.xxx.xxx', 'xxx.xxx.xxx.xxx']


headers = {'Content-Type': 'application/json;charset=utf-8','token': 'xxxxxxxxxxxxxxxxxxxxxx','Request-Origion': 'SwaggerBootstrapUi'}
api_url = 'http://xxx.xxx.xxx.xxx:12345/dolphinscheduler/monitor'


def get_master_status():
    master_metrics = {}
    master_metric = []
    monitor_url = api_url + '/' + 'masters'
    result = requests.get(monitor_url,headers = headers)
    active_masters = []
    masters = result.json().get('data')
    for active_master in masters:
        active_masters.append(active_master.get('host'))
    for master in master_list:
        if master in active_masters:
           master_metric.append({'instance': master,'type': 'dolphinscheduler','value': 1})
        else:
           master_metric.append({'instance': master,'type': 'dolphinscheduler','value': 0})
    master_metrics['instances'] = master_metric
    master_metrics['metric'] = 'custom_dolphinscheduler_master_running_status'
    master_metrics['description'] = 'monitor dolphinscheduler master status, 1 is RUNNING,0 is DOWN'
    return master_metrics

def get_worker_status():
    worker_metrics = {}
    worker_metric = []
    monitor_url = api_url + '/' + 'workers'
    result = requests.get(monitor_url,headers = headers)
    active_workers = []
    workers = result.json().get('data')
    for active_worker in workers:
        active_workers.append(active_worker.get('host'))
    for worker in worker_list:
        if worker in active_workers:
           worker_metric.append({'instance': worker,'type': 'dolphinscheduler','value': 1})
        else:
           worker_metric.append({'instance': worker,'type': 'dolphinscheduler','value': 0})
    worker_metrics['instances'] = worker_metric
    worker_metrics['metric'] = 'custom_dolphinscheduler_worker_running_status'
    worker_metrics['description'] = 'monitor dolphinscheduler worker status, 1 is RUNNING,0 is DOWN'
    return worker_metrics

def main():
    dolphinscheduler_metrics = []
    master_metrics = get_master_status()
    dolphinscheduler_metrics.append(master_metrics)
    worker_metrics = get_worker_status()
    dolphinscheduler_metrics.append(worker_metrics)
    return dolphinscheduler_metrics

if __name__ == "main":
    main()
