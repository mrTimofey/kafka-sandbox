#!/bin/bash
SCRIPT_PATH=$(dirname $(realpath "$0"));
DIST_DIR=${SCRIPT_PATH}/dist;
VERSION=${1:-3.8.0};
ZOO_DIR=apache-zookeeper-${VERSION}-bin;

wget -O ${SCRIPT_PATH}/dist.tar.gz https://dlcdn.apache.org/zookeeper/zookeeper-${VERSION}/${ZOO_DIR}.tar.gz;
tar -C ${SCRIPT_PATH} -xzf ${SCRIPT_PATH}/dist.tar.gz;
rm ${SCRIPT_PATH}/dist.tar.gz;
mkdir -p ${DIST_DIR};
mv ${SCRIPT_PATH}/${ZOO_DIR}/* ${DIST_DIR};
rm -rf ${SCRIPT_PATH}/${ZOO_DIR};
