FROM alpine:latest

RUN adduser -u 1000 -D server
USER server
RUN id

COPY --chown=1000:1000 ./build/bin/geth $HOME/geth
COPY --chown=1000:1000 ./genesis.json $HOME/genesis.json
RUN ls -lah /

RUN mkdir -p ~/.naka
RUN ls -lah /
RUN ./geth --datadir "~/.naka" init ~/genesis.json

# NOT SAFE FOR PROD! change method of adding accts later.
ARG PRIVATE_KEY
ARG PASSWORD
RUN echo $PRIVATE_KEY > ~/.privatekey
RUN echo $PASSWORD > ~/.accountpassword
RUN ./geth account import --password ~/.accountpassword ~/.privatekey

ENV ADDRESS=""
ENV BOOTNODE_ID=""
ENV BOOTNODE_IP=""
CMD exec ./geth --datadir "~/.naka" --syncmode "full" --networkid "25" --targetgaslimit "4700000" --rpc --rpcaddr "0.0.0.0" --rpccorsdomain "*" --bootnodes "enode://$BOOTNODE_ID@$BOOTNODE_IP:30301" --verbosity=4 --unlock $ADDRESS --password "~/.accountpassword" --mine --etherbase $ADDRESS

EXPOSE 8545 30303
