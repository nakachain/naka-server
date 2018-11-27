FROM nakachain/go-naka

RUN adduser -u 1000 -D server
USER server
RUN id

RUN ls -lah ~/.naka
RUN geth --datadir ~/.naka init ~/.naka/genesis.json
