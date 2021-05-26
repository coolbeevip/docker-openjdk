FROM openjdk:8-jre-alpine

MAINTAINER coolbeevip@gmail.com

ARG SKYWALKING_VERSION=8.1.0
ARG SKYWALKING_BIN=apache-skywalking-apm-${SKYWALKING_VERSION}.tar.gz
ARG DOWNLOAD_URL=https://archive.apache.org/dist/skywalking/${SKYWALKING_VERSION}/apache-skywalking-apm-${SKYWALKING_VERSION}.tar.gz

# 设置默认 JVM

ENV JAVA_OPTS="-Xms512m -Xmx1g -Xss256k -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:MaxTenuringThreshold=15 -XX:+ExplicitGCInvokesConcurrent -XX:+CMSParallelRemarkEnabled -XX:SurvivorRatio=8 -XX:+UseCompressedOops"

# 设置 字符集

ENV LANG='en_US.UTF-8' \
    LC_ALL='en_US.UTF-8'

# 设置 SKYWALKING AGENT

ENV SKYWALKING_HOME=/skywalking \
    SKYWALKING_AGENT=/skywalking/agent/skywalking-agent.jar \
    SW_AGENT_NAME=YourAppName

# 设置中国时区 & 常用工具
#libc6-compat
RUN set -x && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk update && \
    apk add --no-cache bash tzdata openssh su-exec unzip libzmq ttf-dejavu curl shadow jattach && \
	cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 安装 glibc 支持
RUN wget -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget -t 0 -c -T 36000 https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-2.29-r0.apk
RUN apk add glibc-2.29-r0.apk
RUN rm -rf /var/cache/apk/*
RUN rm /etc/apk/keys/sgerrand.rsa.pub

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
  && ln -s /usr/local/bin/docker-entrypoint.sh \
  && mkdir ${SKYWALKING_HOME} \
  && wget -t 0 -c -T 3600 ${DOWNLOAD_URL} -P ${SKYWALKING_HOME} \
  && tar -xzvf ${SKYWALKING_HOME}/${SKYWALKING_BIN} -C /skywalking \
  && mv ${SKYWALKING_HOME}/apache-skywalking-apm-bin/agent /skywalking \
  && rm -rf ${SKYWALKING_HOME}/apache-skywalking-apm-bin \
  && rm -rf ${SKYWALKING_HOME}/${SKYWALKING_BIN}

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
