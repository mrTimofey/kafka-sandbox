#!/bin/bash
SCRIPT_PATH=$(dirname $(realpath "$0"));
ZOO_ENSEMBLE_SIZE=${1:-3};

echo Stopping existing ZooKeeper ensemble...
echo;
${SCRIPT_PATH}/stop-ensemble.sh
echo;

echo Starting ZooKeeper ensemble, size: ${ZOO_ENSEMBLE_SIZE}...;
echo;

for (( i=1; i<=${ZOO_ENSEMBLE_SIZE}; i++ )); do
	${SCRIPT_PATH}/start-node.sh ${i} ${ZOO_ENSEMBLE_SIZE};
done;

echo;
${SCRIPT_PATH}/clean-var.sh;
