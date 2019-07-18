# Docker Instructions

## Minimum Requirements

1. Linux-based AMD64 arch type OS
2. Dual-core CPU
3. 2 GB RAM
4. Docker installed

## Build Docker Image

1. `cd docker/[mainnet|testnet]/[client|sealer]`
2. Change `TAG_NAME` in `build.sh` if updating version
3. `./build.sh`

## Set Up Manager Node

1. SSH into server
2. [Init Docker swarm](https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/): `docker swarm init`
3. `cd docker/[mainnet|testnet]/[client|sealer]`
4. Deploy Docker stack: e.g. `docker stack deploy -c docker-compose.yml client-testnet`

## Add Worker Node

1. SSH into server
2. Create the `linked volume` directory in the server, e.g. `mkdir -p /home/ubuntu/.naka/mainnet`. You will need to do this since adding the worker to the swarm won't create the linked volume directory.
3. [Join Docker swarm](https://docs.docker.com/engine/swarm/join-nodes/): `docker swarm join --token SWMTKN-1-3cf4jekd8kfir02lzwi0r3c3tcfbkihvl7ypzv7vle5r4zd32d-29ml6w4pyfwyzone3c09ivq2b 172.31.23.91:2377`

## Update Stack

Please see [https://docs.docker.com/engine/swarm/swarm-tutorial/rolling-update/](https://docs.docker.com/engine/swarm/swarm-tutorial/rolling-update/) if you need to update the service.
