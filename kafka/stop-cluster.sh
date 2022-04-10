#!/bin/bash
SCRIPT_PATH=$(dirname $(realpath "$0"));

for node_dir in ${SCRIPT_PATH}/var/*/ ; do
	if [ -e ${node_dir}/kafka.properties ]; then
		node_id=$(cat ${node_dir}/kafka.properties | grep 'broker.id=');
		node_id=${node_id:10};
		${SCRIPT_PATH}/stop-node.sh ${node_id};
	fi;
done;
