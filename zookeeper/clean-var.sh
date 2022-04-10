#!/bin/bash
SCRIPT_PATH=$(dirname $(realpath "$0"));

echo Cleaning extra node data...
echo;

for node_dir in ${SCRIPT_PATH}/var/*/ ; do
	if [ ! -e ${node_dir}/data/zookeeper_server.pid ]; then
		node_id=$(cat ${node_dir}/data/myid);
		rm -rf ${node_dir};
	fi;
done;
