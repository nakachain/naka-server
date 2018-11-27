FROM nakachain/go-naka

# RUN adduser -u 1000 -D server
# USER server
# RUN id

# COPY --chown=1000:1000 ./build/bin/geth $HOME/geth
# COPY --chown=1000:1000 ./genesis.json $HOME/genesis.json
# RUN ls -lah /

# RUN mkdir -p ~/.naka
# RUN ls -lah /
# RUN geth --datadir ~/.naka init ~/.naka/genesis.json

COPY ./setup/init-genesis.sh /root/.naka/
COPY ./setup/genesis.json /root/.naka/
RUN ls -lah /root
RUN ls -lah /root/.naka
RUN /root/.naka/init-genesis.sh

# NOT SAFE FOR PROD! change method of adding accts later.
ARG PRIVATE_KEY
ARG PASSWORD
RUN echo $PRIVATE_KEY > /root/.naka/.privatekey
RUN cat /root/.naka/.privatekey
RUN echo $PASSWORD > /root/.naka/.accountpw
RUN cat /root/.naka/.accountpw
RUN geth account import --password /root/.naka/.accountpw /root/.naka/.privatekey

ARG ADDRESS
ARG BOOTNODE_ID
ARG BOOTNODE_IP
RUN geth --datadir /root/.naka --syncmode full --networkid 25 --targetgaslimit 4700000 --rpc --rpcaddr 0.0.0.0 --rpccorsdomain "*" --verbosity 4 --mine --bootnodes "enode://$BOOTNODE_ID@$BOOTNODE_IP:30301" --etherbase "$ADDRESS" --unlock "$ADDRESS" --password /root/.naka/.accountpw

EXPOSE 8545 30303
