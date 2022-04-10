#!/bin/bash
SCRIPT_PATH=$(dirname $(realpath "$0"));
KAFKA_CLUSTER_SIZE=${1:-3};

echo Stopping existing Kafka cluster...
echo;
${SCRIPT_PATH}/stop-cluster.sh;
echo;

echo Starting Kafka cluster, size: ${KAFKA_CLUSTER_SIZE}...;
echo;

for (( i=1; i<=${KAFKA_CLUSTER_SIZE}; i++ )); do
	${SCRIPT_PATH}/start-node.sh ${i} ${KAFKA_CLUSTER_SIZE};
done;

echo;
${SCRIPT_PATH}/clean-var.sh;
