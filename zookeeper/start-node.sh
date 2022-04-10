#!/bin/bash
## ${1} - ZooKeeper node number (myid)
## ${2} - ZooKeeper ensemble size

SCRIPT_PATH=$(dirname $(realpath "$0"));

## files and directories for this node
NODE_DIR=${SCRIPT_PATH}/var/node-${1};
NODE_CFG=${NODE_DIR}/zoo.cfg;
NODE_LOG_DIR=${NODE_DIR}/log;
NODE_DATA_DIR=${NODE_DIR}/data
CLIENT_PORT=218${1};
ADMIN_PORT=809${1};
SERVER_PORTS=288${1}:289${1}
mkdir -p ${NODE_DATA_DIR};

## make ZooKeeper config file
cat ${SCRIPT_PATH}/zoo.cfg > ${NODE_CFG};
echo "
clientPort=${CLIENT_PORT}
dataDir=${NODE_DATA_DIR}
admin.serverPort=${ADMIN_PORT}" >> ${NODE_CFG};
## add all ensemble nodes to the config file
for (( i=1; i<=${2}; i++ )); do
	echo "server.${i}=localhost:288${i}:289${i}" >> ${NODE_CFG};
done;

## myid file is needed to self indentify this node in the ensemble
echo ${1} > ${NODE_DATA_DIR}/myid;

## start the node
ZOO_LOG_DIR=${NODE_LOG_DIR} ${SCRIPT_PATH}/dist/bin/zkServer.sh start ${NODE_CFG} >/dev/null 2>&1;

echo ZooKeeper node \#${1} is listening on port ${CLIENT_PORT}, admin port is ${ADMIN_PORT}, server ports are ${SERVER_PORTS};
