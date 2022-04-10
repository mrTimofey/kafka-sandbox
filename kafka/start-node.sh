#!/bin/bash
## ${1} - Kafka node number
## ${2} - Kafka cluster size

SCRIPT_PATH=$(dirname $(realpath "$0"));

## files and directories for this node
NODE_DIR=${SCRIPT_PATH}/var/node-${1};
NODE_CFG=${NODE_DIR}/kafka.properties;
ZOO_ENSEMBLE_VAR=$(cd ${SCRIPT_PATH}/../zookeeper/var; pwd);
REST_PORT=810${1};
LISTENER_PORT=909${1};
mkdir -p ${NODE_DIR};

zookeepers=();

for zoo_node_dir in ${ZOO_ENSEMBLE_VAR}/*/ ; do
	if [ -e ${zoo_node_dir}/data/zookeeper_server.pid ]; then
		port=$(cat ${zoo_node_dir}/zoo.cfg | grep 'clientPort=');
		port=${port:11}
		zookeepers+=("localhost:${port}");
	fi;
done;

## make Kafka config file
cat ${SCRIPT_PATH}/kafka.properties > ${NODE_CFG};
echo "
broker.id=${1}
listeners=PLAINTEXT://:${LISTENER_PORT}
log.dirs=${NODE_DIR}/logs
zookeeper.connect=$(IFS=,; echo "${zookeepers[*]}")
min.insync.replicas=$((${2} / 2 + 1))
offsets.topic.replication.factor=${2}
transaction.state.log.replication.factor=${2}
default.replication.factor=${2}
num.partitions=${2}
rest.port=${REST_PORT}" >> ${NODE_CFG};

## start the node
LOG_DIR=${NODE_DIR}/logs ${SCRIPT_PATH}/dist/bin/kafka-server-start.sh -daemon ${NODE_CFG};
echo Kafka node \#${1} is listening on port ${LISTENER_PORT}, REST API port ${REST_PORT};
