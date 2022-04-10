#!/bin/bash
SCRIPT_PATH=$(dirname $(realpath "$0"));

for node_dir in ${SCRIPT_PATH}/var/*/ ; do
	if [ -e ${node_dir}/data/zookeeper_server.pid ]; then
		node_id=$(cat ${node_dir}/data/myid);
		${SCRIPT_PATH}/stop-node.sh ${node_id};
	fi;
done;
