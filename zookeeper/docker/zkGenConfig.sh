#!/usr/bin/env bash
# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ZK_CLIENT_PORT=${ZK_CLIENT_PORT:-2181}
ZK_SERVER_PORT=${ZK_SERVER_PORT:-2888}
ZK_ELECTION_PORT=${ZK_ELECTION_PORT:-3888}
ZOOCFGDIR=${ZOOCFGDIR:-"/conf"}
ZOO_DATA_DIR=${ZOO_DATA_DIR:-"/var/lib/zookeeper/data"}
ZOO_DATA_LOG_DIR=${ZK_DATA_LOG_DIR:-"/var/lib/zookeeper/datalog"} 
ZOO_LOG_DIR=${ZOO_LOG_DIR:-"/var/lib/zookeeper/logs"}
ZOO_LOG4J_PROP=${ZOO_LOG4J_PROP:-"INFO,CONSOLE"}
ZOO_4LW_COMMANDS_WHITELIST=${ZOO_4LW_COMMANDS_WHITELIST:-"stat, ruok, conf, isro"}
ZOO_TICK_TIME=${ZOO_TICK_TIME:-2000}
ZOO_INIT_LIMIT=${ZOO_INIT_LIMIT:-10}
ZOO_SYNC_LIMIT=${ZOO_SYNC_LIMIT:-5}
ZOO_SERVER_HEAP=${ZOO_SERVER_HEAP:-1000}
ZOO_MAX_CLIENT_CNXNS=${ZOO_MAX_CLIENT_CNXNS:-60}
ZOO_MIN_SESSION_TIMEOUT=${ZOO_MIN_SESSION_TIMEOUT:- $((ZOO_TICK_TIME*2))}
ZOO_MAX_SESSION_TIMEOUT=${ZOO_MAX_SESSION_TIMEOUT:- $((ZOO_TICK_TIME*20))}
ZOO_AUTOPURGE_SNAPRETAINCOUNT=${ZOO_AUTOPURGE_SNAPRETAINCOUNT:-3}
ZOO_AUTOPURGE_PURGEINTERVAL=${ZOO_AUTOPURGE_PURGEINTERVAL:-0}
ZOOCFG="$ZOOCFGDIR/zoo.cfg"
ID_FILE="$ZOO_DATA_DIR/myid"
HOST=`hostname -s`
DOMAIN=`hostname -d`
ZK_REPLICAS=3

function print_servers() {
    for (( i=1; i<=$ZK_REPLICAS; i++ ))
    do
        echo "server.$i=$NAME-$((i-1)).$DOMAIN:$ZK_SERVER_PORT:$ZK_ELECTION_PORT"
    done
}

function validate_env() {
    echo "Validating environment"

    if [ -z $ZK_REPLICAS ]; then
        echo "ZK_REPLICAS is a mandatory environment variable"
        exit 1
    fi

    if [[ $HOST =~ (.*)-([0-9]+)$ ]]; then
        NAME=${BASH_REMATCH[1]} ORD=${BASH_REMATCH[2]}
    else
        echo "Failed to extract ordinal from hostname $HOST"
        exit 1
    fi

    MY_ID=$((ORD+1))
    echo "ZK_REPLICAS=$ZK_REPLICAS"
    echo "MY_ID=$MY_ID"
    echo "ZOO_LOG4J_PROP=$ZOO_LOG4J_PROP"
    echo "ZOO_DATA_DIR=$ZOO_DATA_DIR"
    echo "ZOO_DATA_LOG_DIR=$ZOO_DATA_LOG_DIR"
    echo "ZOO_LOG_DIR=$ZOO_LOG_DIR"
    echo "ZK_CLIENT_PORT=$ZK_CLIENT_PORT"
    echo "ZK_SERVER_PORT=$ZK_SERVER_PORT"
    echo "ZK_ELECTION_PORT=$ZK_ELECTION_PORT"
    echo "ZOO_TICK_TIME=$ZOO_TICK_TIME"
    echo "ZOO_INIT_LIMIT=$ZOO_INIT_LIMIT"
    echo "ZOO_SYNC_LIMIT=$ZOO_SYNC_LIMIT"
    echo "ZOO_MAX_CLIENT_CNXNS=$ZOO_MAX_CLIENT_CNXNS"
    echo "ZOO_MIN_SESSION_TIMEOUT=$ZOO_MIN_SESSION_TIMEOUT"
    echo "ZOO_MAX_SESSION_TIMEOUT=$ZOO_MAX_SESSION_TIMEOUT"
    echo "ZOO_SERVER_HEAP=$ZOO_SERVER_HEAP"
    echo "ZOO_AUTOPURGE_PURGEINTERVAL=$ZOO_AUTOPURGE_PURGEINTERVAL"
    echo "ZOO_AUTOPURGE_SNAPRETAINCOUNT=$ZOO_AUTOPURGE_SNAPRETAINCOUNT"
    echo "ZOO_4LW_COMMANDS_WHITELIST=$ZOO_4LW_COMMANDS_WHITELIST"
    echo "ENSEMBLE"
    print_servers
    echo "Environment validation successful"
}

function create_config() {
    rm -f $ZOOCFG
    echo "Creating ZooKeeper configuration"
    echo "#This file was autogenerated by k8szk DO NOT EDIT" >> $ZOOCFG
    echo "clientPort=$ZK_CLIENT_PORT" >> $ZOOCFG
    echo "dataDir=$ZOO_DATA_DIR" >> $ZOOCFG
    echo "dataLogDir=$ZOO_DATA_LOG_DIR" >> $ZOOCFG
    echo "tickTime=$ZOO_TICK_TIME" >> $ZOOCFG
    echo "initLimit=$ZOO_INIT_LIMIT" >> $ZOOCFG
    echo "syncLimit=$ZOO_SYNC_LIMIT" >> $ZOOCFG
    echo "minSessionTimeout=$ZOO_MIN_SESSION_TIMEOUT" >> $ZOOCFG
    echo "maxSessionTimeout=$ZOO_MAX_SESSION_TIMEOUT" >> $ZOOCFG
    echo "autopurge.snapRetainCount=$ZOO_AUTOPURGE_SNAPRETAINCOUNT" >> $ZOOCFG
    echo "autopurge.purgeInteval=$ZOO_AUTOPURGE_PURGEINTERVAL" >> $ZOOCFG
    echo "4lw.commands.whitelist=$ZOO_4LW_COMMANDS_WHITELIST" >> $ZOOCFG

    if [ $ZK_REPLICAS -gt 1 ]; then
        print_servers >> $ZOOCFG
    fi

    echo "Wrote ZooKeeper configuration file to $ZOOCFG"
}

function create_data_dirs() {
    echo "Creating ZooKeeper data directories and setting permissions"

    if [ ! -d $ZOO_DATA_DIR  ]; then
        mkdir -p $ZOO_DATA_DIR
    fi

    if [ ! -d $ZOO_DATA_LOG_DIR  ]; then
        mkdir -p $ZOO_DATA_LOG_DIR
    fi

    if [ ! -d $ZOO_LOG_DIR  ]; then
        mkdir -p $ZOO_LOG_DIR
    fi

    if [ ! -f $ID_FILE ]; then
        echo $MY_ID >> $ID_FILE
    fi

    echo "Created ZooKeeper data directories and set permissions in $ZK_DATA_DIR"
}

validate_env && create_config  && create_data_dirs 
