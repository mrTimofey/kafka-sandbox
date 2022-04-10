#!/bin/bash
SCRIPT_PATH=$(dirname $(realpath "$0"));

echo Cleaning extra node data...
echo;

for node_dir in ${SCRIPT_PATH}/var/*/ ; do
	node_pid=$(ps ax | grep ' kafka\.Kafka ' | grep ${node_dir}kafka.properties | grep java | grep -v grep | awk '{print $1}');
	if [ "x$node_pid" = 'x' ]; then
		rm -rf $node_dir;
	fi;
done;
