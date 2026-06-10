FROM alpine:3.19

RUN apk add --no-cache \
    bash \
    procps \
    util-linux \
    coreutils \
    grep \
    gawk

WORKDIR /app
COPY server-stats-acferriol.sh .
RUN chmod +x server-stats-acferriol.sh

ENTRYPOINT ["/app/server-stats-acferriol.sh"]