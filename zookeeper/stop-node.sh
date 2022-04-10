#!/bin/bash
## ${1} - ZooKeeper node number (myid)

SCRIPT_PATH=$(dirname $(realpath "$0"));
ZOO_NODE_CFG=${SCRIPT_PATH}/var/node-${1}/zoo.cfg;

${SCRIPT_PATH}/dist/bin/zkServer.sh stop ${ZOO_NODE_CFG} >/dev/null 2>&1;
echo ZooKeeper node \#${1} is stopped;
