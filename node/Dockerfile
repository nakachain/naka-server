FROM nakachain/go-naka

# RUN adduser -u 1000 -D server
# USER server
# RUN id

# Run init genesis script if needed
COPY ./setup/genesis.json /root/.naka/
COPY ./setup/init-genesis.sh /usr/local/bin
COPY ./setup/start-node.sh /usr/local/bin
RUN init-genesis.sh

# NOT SAFE FOR PROD! change method of adding accts later.
ARG PRIVATE_KEY
ARG PASSWORD
RUN echo $PRIVATE_KEY > /root/.naka/.privatekey
RUN echo $PASSWORD > /root/.naka/.accountpw
RUN geth --datadir /root/.naka account import --password /root/.naka/.accountpw /root/.naka/.privatekey

# Run geth script
ENTRYPOINT ["start-node.sh"]

EXPOSE 8545 30303
