#!/bin/bash
## ${1} - Kafka node number

SCRIPT_PATH=$(dirname $(realpath "$0"));

node_pid=$(ps ax | grep ' kafka\.Kafka ' | grep ${SCRIPT_PATH}/var/node-${1}/kafka.properties | grep java | grep -v grep | awk '{print $1}')

if [ "x${node_pid}" != x ]; then
	kill -s TERM ${node_pid};
	while ps -p ${node_pid} >/dev/null; do sleep 0.1; done;
	echo Kafka node \#${1} is stopped
fi;
