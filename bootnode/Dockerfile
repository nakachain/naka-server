FROM nakachain/bootnode:v1.3.0

# RUN adduser -u 1000 -D server
# USER server

# Copy bootkey
RUN mkdir /root/.naka
COPY ./setup/boot.key /root/.naka

# Start bootnode
CMD ["-nodekey", "/root/.naka/boot.key", "-verbosity", "9"]

EXPOSE 30301
