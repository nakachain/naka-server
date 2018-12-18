ARG IMAGE=nakachain/bootnode:latest
FROM ${IMAGE}
RUN echo "Using ${IMAGE}"

# Run init genesis script if needed
COPY ./setup/genesis.json /root/.naka/
COPY ./setup/init-genesis.sh /usr/local/bin
COPY ./client/start-client.sh /usr/local/bin
RUN init-genesis.sh

# Run geth script
ENTRYPOINT ["start-client.sh"]

EXPOSE 8545 8546 30303
