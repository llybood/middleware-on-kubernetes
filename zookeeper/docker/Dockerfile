FROM zookeeper:3.6.3
RUN apt-get update && \
    apt-get install -y --no-install-recommends procps && \
    rm -rf /var/lib/apt/lists/*
COPY zkGenConfig.sh zkOk.sh /apache-zookeeper-3.6.3-bin/bin/
RUN chown zookeeper.zookeeper /apache-zookeeper-3.6.3-bin/bin/zkGenConfig.sh && \
chown zookeeper.zookeeper /apache-zookeeper-3.6.3-bin/bin/zkOk.sh && \
chmod +x /apache-zookeeper-3.6.3-bin/bin/zkGenConfig.sh && \
chmod +x /apache-zookeeper-3.6.3-bin/bin/zkOk.sh

