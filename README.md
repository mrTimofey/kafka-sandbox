# Kafka sandbox

Set of scripts to make a local Kafka+ZooKeeper cluster. No brains needed.

## Quick start

Download binaries (once):

```bash
./zookeeper/install.sh
./kafka/install.sh
```

Start ZooKeeper ensemble with 3 nodes: `./zookeeper/start-ensemble.sh`. ZooKeeper client connection ports: 2181, 2182, 2183.

Start Kafka cluster with 3 nodes: `./kafka/start-cluster.sh` Kafka client connection ports: 9091, 9092, 9093.

Stop ZooKeeper: `./zookeeper/stop-ensemble.sh`.

Stop Kafka: `./kafka/stop-cluster.sh`.

See `zookeeper` and `kafka` folders to learn more.
