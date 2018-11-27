FROM nakachain/go-naka

# Run init genesis script if needed
COPY ./setup/genesis.json /root/.naka/
COPY ./setup/init-genesis.sh /usr/local/bin
COPY ./setup/start-node.sh /usr/local/bin
RUN init-genesis.sh

# Run geth script
ENTRYPOINT ["start-node.sh"]

EXPOSE 8545 30303
