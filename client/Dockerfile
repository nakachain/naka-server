FROM nakachain/go-naka:v1.4.1

# Copy static-nodes.json
ARG STATIC_NODE_PATH
COPY ${STATIC_NODE_PATH} /root/.naka/geth

# Copy genesis.json
ARG GENESIS_PATH
COPY ${GENESIS_PATH} /root/.naka/

# Run init genesis script
COPY ./script/init-genesis.sh /usr/local/bin
RUN init-genesis.sh

# Create env vars for shell script
ARG BOOTNODES
ARG CHAIN_ID
ENV BOOTNODES=$BOOTNODES
ENV CHAIN_ID=$CHAIN_ID

# Run start script
COPY ./client/start-client.sh /usr/local/bin
ENTRYPOINT ["start-client.sh"]

# Expose ports
ARG EXPOSED_PORTS
EXPOSE ${EXPOSED_PORTS}
