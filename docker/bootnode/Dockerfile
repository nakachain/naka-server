FROM nakachain/bootnode

# RUN adduser -u 1000 -D server
# USER server

RUN mkdir /root/.naka
COPY ./setup/boot.key /root/.naka

CMD ["-nodekey", "/root/.naka/boot.key", "-verbosity", "9"]

# COPY --chown=1000:1000 ./build/bin/bootnode /usr/local/bin/

# CMD exec /usr/local/bin/bootnode -nodekey "~/.naka/boot.key" -verbosity 9

EXPOSE 30301/udp
