## Client Node
A client node is a non-sealer node.

**Start**
1. `docker-compose -f docker-compose-client.yml up --build -d`
2. After Docker container finishes starting, `cd client`
3. Attach geth to node: `./attach.sh ${DOCKER_CONTAINER_NAME}`
4. Add peer to start syncing: `admin.addPeer('enode://e5a07fee57a0bb0101e6e1ad79cdbfc0784181414f8e75f29f8dc7b707c5d5babfa52342325aa2dc5e5f4a97440532ef2e82093530e03a80cc38f78d50278573@52.194.161.36:30303')`

**Stop**
```
docker-compose -f docker-compose-client.yml down
```

## Sealer Node
You will need to create an `.env` file in the proper folder (mainnet/testnet) before deploying the sealer nodes.

**Example .env file**
```
CHAIN_ID=12345
NODE1_ADDRESS=0x1234567890123456789012345678901234567890
NODE1_PRIVATE_KEY=1234567890123456789012345678901234567890123456789012345678901234
NODE1_PASSWORD=mypw
NODE2_ADDRESS=0x1234567890123456789012345678901234567890
NODE2_PRIVATE_KEY=1234567890123456789012345678901234567890123456789012345678901234
NODE2_PASSWORD=mypw
```

**Start**
```
docker-compose -f docker-compose-server.yml up --build -d
```

**Stop**
```
docker-compose -f docker-compose-server.yml down
```
