FROM nakachain/go-naka:v1.4.1

# Copy static-nodes.json
ARG STATIC_NODE_PATH
COPY ${STATIC_NODE_PATH} /root/.naka/geth

# Copy genesis.json
ARG GENESIS_PATH
COPY ${GENESIS_PATH} /root/.naka/

# Run init genesis script
COPY ./script/init-genesis.sh /usr/local/bin
# RUN init-genesis.sh

# Import account
ARG PRIVATE_KEY
ARG PASSWORD
RUN echo $PRIVATE_KEY > /root/.naka/.privatekey
RUN echo $PASSWORD > /root/.naka/.accountpw
RUN geth --datadir /root/.naka account import --password /root/.naka/.accountpw /root/.naka/.privatekey

# Create env vars for shell script
ARG BOOTNODES
ARG CHAIN_ID
ARG ADDRESS
ARG ETHERBASE_ADDRESS
ENV BOOTNODES=$BOOTNODES
ENV CHAIN_ID=$CHAIN_ID
ENV ETHERBASE_ADDRESS=$ETHERBASE_ADDRESS
ENV ADDRESS=$ADDRESS

# Run start script
COPY ./node/start-node.sh /usr/local/bin
ENTRYPOINT ["start-node.sh"]

# Expose ports
ARG EXPOSED_PORTS
EXPOSE ${EXPOSED_PORTS}
