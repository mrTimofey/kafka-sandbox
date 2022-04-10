#!/bin/bash
SCRIPT_PATH=$(dirname $(realpath "$0"));
DIST_DIR=${SCRIPT_PATH}/dist;
KAFKA_DIR=kafka_2.13-3.1.0;

wget -O ${SCRIPT_PATH}/dist.tgz https://dlcdn.apache.org/kafka/3.1.0/kafka_2.13-3.1.0.tgz;
tar -C ${SCRIPT_PATH} -xzf ${SCRIPT_PATH}/dist.tgz;
rm ${SCRIPT_PATH}/dist.tgz;
mkdir -p ${DIST_DIR};
mv ${SCRIPT_PATH}/${KAFKA_DIR}/* ${DIST_DIR};
rm -rf ${SCRIPT_PATH}/${KAFKA_DIR};
