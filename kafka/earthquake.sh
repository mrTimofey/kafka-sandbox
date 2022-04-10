#!/bin/bash
SCRIPT_PATH=$(dirname $(realpath "$0"));

exiting=false;
kafka_cluster_size=0;

function on_exit() {
	exiting=true;
	echo;
	echo Earthquake is over, starting all nodes...
	for (( i=1; i<=${kafka_cluster_size}; i++ )); do
		${SCRIPT_PATH}/start-node.sh ${i} ${kafka_cluster_size} &> /dev/null;
	done;
	echo Everything is back to normal
}

trap on_exit INT;

for node_dir in ${SCRIPT_PATH}/var/*/ ; do
	if [ $(ps ax | grep ' kafka\.Kafka ' | grep ${node_dir}kafka.properties | grep java | grep -v grep | awk '{print $1}') ]; then
		((++kafka_cluster_size))
	fi;
done;

echo $kafka_cluster_size

echo Earthquake started, Kafka nodes unstable...
echo Cluster size: ${kafka_cluster_size};

until ${exiting}; do
	node_num=$((${RANDOM}%${kafka_cluster_size}+1));
	echo Kafka node \#${node_num} is going down...;
	if ${exiting}; then break; fi;
	${SCRIPT_PATH}/stop-node.sh ${node_num} &> /dev/null;
	sleep 1;
	if ${exiting}; then break; fi;
	${SCRIPT_PATH}/start-node.sh ${node_num} ${kafka_cluster_size} &> /dev/null;
	echo Kafka node \#${node_num} is up again, god knows for how long...;
done;
