# Local ZooKeeper cluster sandbox

## Start cluster/ensemble

`start-ensemble.sh [{node count, default: 3}]`

The command will create configuration files for each node and start them as a single cluster.

Port numbers for each node are set by a node number from 1 to node count:

```
# client connection port
clientPort=218{node number}
# Admin Server port
admin.serverPort=809{node number}
# leader election port
server.{node number}=localhost:288${node number}:289${node number}
```

Shared config can be customized in `./zoo.cfg`. You can see particular node configuration file in `./var/node-{node number}/zoo.cfg`.

## Stop cluster/ensemble

`stop-ensemble.sh`

## Start single node

`start-node.sh {node number} {cluster node count}`

## Stop single node

`stop-node.sh {node number}`

## Fails simulation

`./earthquake.sh`

This command randomly kills single node every second. Stop the command (CTRL+C) to restore cluster integrity.
