FROM nakachain/go-naka

# RUN adduser -u 1000 -D server
# USER server
# RUN id

RUN mkdir /root/.naka
COPY ./setup/genesis.json /root/.naka

RUN ls -lah /root
RUN ls -lah /root/.naka
RUN geth --datadir /root/.naka init /root/.naka/genesis.json
