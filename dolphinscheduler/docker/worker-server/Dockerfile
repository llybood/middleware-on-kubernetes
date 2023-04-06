FROM apache/dolphinscheduler-worker:3.1.1
# 拷贝mysql驱动
COPY mysql-connector-java-8.0.16.jar /opt/dolphinscheduler/libs
# 拷贝datax
ADD datax.tar.gz /opt/soft/
RUN apt-get update && \
    apt-get install -y --no-install-recommends python2 && \
    rm -rf /var/lib/apt/lists/*
