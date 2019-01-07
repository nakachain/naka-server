FROM nakachain/bootnode:v1.4.1

# Copy bootkey
RUN mkdir /root/.naka
ARG BOOTKEY_PATH
COPY ${BOOTKEY_PATH} /root/.naka

# Start bootnode
CMD ["-nodekey", "/root/.naka/boot.key", "-verbosity", "9"]

EXPOSE 30301
