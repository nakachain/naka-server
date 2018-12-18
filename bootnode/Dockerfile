ARG IMAGE=nakachain/bootnode:latest
FROM ${IMAGE}
RUN echo "Using ${IMAGE}"

# RUN adduser -u 1000 -D server
# USER server

# Copy bootkey
RUN mkdir /root/.naka
COPY ./setup/boot.key /root/.naka

# Start bootnode
CMD ["-nodekey", "/root/.naka/boot.key", "-verbosity", "9"]

EXPOSE 30301
