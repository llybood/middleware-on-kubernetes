FROM alpine:latest

# Keepalived version
ARG KEEPALIVED_VERSION=2.2.7

# Add keepalived default script user to make sure their IDs get assigned consistently,
# regardless of whatever dependencies get added
# RUN addgroup -S keepalived_script && adduser -D -S -G keepalived_script keepalived_script

# 1. install required libraries and tools
# 2. compile and install keepalived
# 3. remove keepalived sources and unnecessary libraries and tools
RUN apk --no-cache add \
    curl \
    binutils \
    file \
    file-dev \
    gcc \
    glib \
    glib-dev \
    ipset \
    ipset-dev \
    iptables \
    iptables-dev \
    libmnl-dev \
    libnftnl-dev \
    libnl3 \
    libnl3-dev \
    make \
    musl-dev \
    net-snmp-dev \
    openssl \
    openssl-dev \
    pcre2 \
    pcre2-dev \
    autoconf \
    automake \
    bash \
    bash-completion \
    iproute2 \
    tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && curl -o keepalived.tar.gz -SL http://keepalived.org/software/keepalived-${KEEPALIVED_VERSION}.tar.gz \
    && tar -xf keepalived.tar.gz \
    && cd keepalived-${KEEPALIVED_VERSION} \
    && ./autogen.sh \
    && ./configure \
	--disable-dynamic-linking \
	--prefix=/usr \
	--exec-prefix=/usr \
	--bindir=/usr/bin \
	--sbindir=/usr/sbin \
	--sysconfdir=/etc \
	--datadir=/usr/share \
	--localstatedir=/var \
	--mandir=/usr/share/man \
    && make && make install \
    && strip /usr/sbin/keepalived \
    && rm -rf keepalived-${KEEPALIVED_VERSION} \
    && apk --no-cache del \
        binutils \
        file-dev \
        gcc \
        glib-dev \
        ipset-dev \
        iptables-dev \
        libmnl-dev \
        libnl3-dev \
        libnftnl-dev \
        make \
        musl-dev \
        openssl-dev \
        pcre2-dev \
        autoconf \
        automake

# set keepalived as image entrypoint with --dont-fork and --log-console (to make it docker friendly)
# define /etc/keepalived/keepalived.conf as the configuration file to use
ENTRYPOINT ["/usr/sbin/keepalived","--dont-fork","--log-console", "-f","/etc/keepalived/keepalived.conf"]

# example command to customise keepalived daemon:
CMD ["--log-detail","--dump-conf"]
