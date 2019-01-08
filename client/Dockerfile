FROM nakachain/go-naka:v1.4.1

# Copy genesis.json
ARG GENESIS_PATH
COPY ${GENESIS_PATH} /root/.naka/

# Run init genesis script
COPY ./script/init-genesis.sh /usr/local/bin
RUN init-genesis.sh

# Run start script
COPY ./client/start-client.sh /usr/local/bin
ENTRYPOINT ["start-client.sh"]

# Expose ports
ARG EXPOSED_PORTS
EXPOSE ${EXPOSED_PORTS}
