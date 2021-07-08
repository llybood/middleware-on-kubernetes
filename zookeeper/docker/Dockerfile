FROM zookeeper:3.6.3
RUN apt-get update && \
    apt-get install -y --no-install-recommends procps && \
    rm -rf /var/lib/apt/lists/*
COPY zkGenConfig.sh zkOk.sh /apache-zookeeper-3.6.3-bin/bin/

