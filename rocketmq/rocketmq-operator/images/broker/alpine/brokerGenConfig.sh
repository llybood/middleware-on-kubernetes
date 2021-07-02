#!/bin/bash

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

BROKER_CONFIG_FILE="$ROCKETMQ_HOME/conf/broker.conf"
echo $BROKER_CONFIG_FILE

BROKER_ROLE="SLAVE"

if [ $BROKER_ID = 0 ];then
    if [ $REPLICATION_MODE = "SYNC" ];then
      BROKER_ROLE="SYNC_MASTER"
    else
      BROKER_ROLE="ASYNC_MASTER"
    fi
fi

#BROKER_NAME=$(cat /etc/hostname)
DELETE_WHEN="04"
FILE_RESERVED_TIME="48"
FLUSH_DISK_TYPE="ASYNC_FLUSH"

function create_config() {
    rm -f $BROKER_CONFIG_FILE
    echo "Creating broker configuration."
    echo "#This file was auto generated by rocketmq-operator. DO NOT EDIT." >> $BROKER_CONFIG_FILE
    echo "brokerClusterName=$BROKER_CLUSTER_NAME" >> $BROKER_CONFIG_FILE
    echo "brokerName=$BROKER_NAME" >> $BROKER_CONFIG_FILE
    echo "brokerId=$BROKER_ID" >> $BROKER_CONFIG_FILE
    echo "deleteWhen=$DELETE_WHEN" >> $BROKER_CONFIG_FILE
    echo "fileReservedTime=$FILE_RESERVED_TIME" >> $BROKER_CONFIG_FILE
    echo "brokerRole=$BROKER_ROLE" >> $BROKER_CONFIG_FILE
    echo "flushDiskType=$FLUSH_DISK_TYPE" >> $BROKER_CONFIG_FILE
    echo "Wrote broker configuration file to $BROKER_CONFIG_FILE"
}


create_config