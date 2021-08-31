FROM alpine:3.13

ENV LANG=C.UTF-8

RUN set -eux && mkdir -p /app/skywalking/agent/

ADD apache-skywalking-apm-bin/agent/ /app/skywalking/agent/

WORKDIR /

