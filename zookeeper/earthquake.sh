#!/bin/bash
SCRIPT_PATH=$(dirname $(realpath "$0"));

exiting=false;
zoo_ensemble_size=0;

function on_exit() {
	exiting=true;
	echo;
	echo Earthquake is over, starting all nodes...
	for (( i=1; i<=${zoo_ensemble_size}; i++ )); do
		${SCRIPT_PATH}/start-node.sh ${i} ${zoo_ensemble_size} &> /dev/null;
	done;
	echo Everything is back to normal
}

trap on_exit INT;

for node_dir in ${SCRIPT_PATH}/var/*/ ; do
	if [ -e ${node_dir}/data/zookeeper_server.pid ]; then
		((++zoo_ensemble_size))
	fi;
done;

echo Earthquake started, ZooKeeper nodes unstable...
echo Ensemble size: ${zoo_ensemble_size};

until ${exiting}; do
	node_num=$((${RANDOM}%${zoo_ensemble_size}+1));
	echo ZooKeeper node \#${node_num} is going down...;
	if ${exiting}; then break; fi;
	${SCRIPT_PATH}/stop-node.sh ${node_num} &> /dev/null;
	sleep 1;
	if ${exiting}; then break; fi;
	${SCRIPT_PATH}/start-node.sh ${node_num} ${zoo_ensemble_size} &> /dev/null;
	echo ZooKeeper node \#${node_num} is up again, god knows for how long...;
done;
