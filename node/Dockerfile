FROM nakachain/go-naka:v1.4.1

# Copy genesis.json
ARG GENESIS_PATH
COPY ${GENESIS_PATH} /root/.naka/

# Run init genesis script
ARG INIT_GENESIS_PATH
COPY ${INIT_GENESIS_PATH} /usr/local/bin
RUN init-genesis.sh

# Import account
# NOT SAFE FOR PROD! change method of adding accts later.
ARG PRIVATE_KEY
ARG PASSWORD
RUN echo $PRIVATE_KEY > /root/.naka/.privatekey
RUN echo $PASSWORD > /root/.naka/.accountpw
RUN geth --datadir /root/.naka account import --password /root/.naka/.accountpw /root/.naka/.privatekey

# Run start script
COPY ./node/start-node.sh /usr/local/bin
ENTRYPOINT ["start-node.sh"]

# Expose ports
ARG EXPOSED_PORTS
EXPOSE ${EXPOSED_PORTS}
