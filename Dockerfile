FROM debian:stretch-slim

ENV DOGECOIND_VERSION 1.14.2
ENV DOGECOIN_URL https://github.com/dogecoin/dogecoin/releases/download/v${DOGECOIND_VERSION}/dogecoin-$DOGECOIND_VERSION-x86_64-linux-gnu.tar.gz

RUN apt-get update --fix-missing
RUN apt-get install -qq --no-install-recommends \
    curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

RUN curl -o dogecoin.tar.gz -Lk "$DOGECOIN_URL" && \
    tar -xzvf dogecoin.tar.gz -C /usr/local --strip-components=1 --exclude=*-qt && \
    rm dogecoin.tar.gz

EXPOSE 9998 9999 19998 19999

ENTRYPOINT dogecoind -printtoconsole -shrinkdebugfile