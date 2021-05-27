FROM openjdk:8-jre-alpine

MAINTAINER zhanglei@apache.org

ARG SKYWALKING_VERSION=8.1.0
ARG SKYWALKING_BIN=apache-skywalking-apm-${SKYWALKING_VERSION}.tar.gz
ARG DOWNLOAD_URL=https://archive.apache.org/dist/skywalking/${SKYWALKING_VERSION}/apache-skywalking-apm-${SKYWALKING_VERSION}.tar.gz

ENV LANG='en_US.UTF-8' \
    LC_ALL='en_US.UTF-8' \
    SKYWALKING_HOME=/skywalking \
    SKYWALKING_AGENT=/skywalking/agent/skywalking-agent.jar \
    SW_AGENT_NAME=YourAppName \
    JAVA_TOOL_OPTIONS=" \
      -Xms256m \
      -Xmx1g \
      -Xss256k \
      -XX:MetaspaceSize=128m \
      -XX:MaxMetaspaceSize=512m \
      -Xnoclassgc \
      -XX:+UseConcMarkSweepGC \
      -XX:+UseParNewGC \
      -XX:ParallelGCThreads=12 \
      -XX:MaxTenuringThreshold=15 \
      -XX:+ExplicitGCInvokesConcurrent \
      -XX:+CMSParallelRemarkEnabled \
      -XX:SurvivorRatio=8 \
      -XX:CMSInitiatingOccupancyFraction=65 \
      -XX:+UseCMSInitiatingOccupancyOnly \
      -XX:+UseCMSCompactAtFullCollection \
      -XX:+CMSClassUnloadingEnabled \
      -XX:+PrintGCDetails \
      -XX:+UseGCLogFileRotation \
      -XX:NumberOfGCLogFiles=10 \
      -XX:GCLogFileSize=1024k \
      -XX:+PrintGCDateStamps \
      -XX:+PrintGCTimeStamps \
      -Xloggc:logs/gc-$(date +%s).vgc"

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN set -x && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk update && \
    apk add --no-cache bash tzdata openssh su-exec unzip libzmq ttf-dejavu curl shadow jattach && \
	  cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    wget -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget -t 0 -c -T 36000 https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-2.29-r0.apk && \
    apk add glibc-2.29-r0.apk && \
    rm -rf /var/cache/apk/* && \
    rm /etc/apk/keys/sgerrand.rsa.pub && \
    rm glibc-2.29-r0.apk

RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
  && ln -s /usr/local/bin/docker-entrypoint.sh \
  && mkdir ${SKYWALKING_HOME} \
  && wget -t 0 -c -T 3600 ${DOWNLOAD_URL} -P ${SKYWALKING_HOME} \
  && tar -xzvf ${SKYWALKING_HOME}/${SKYWALKING_BIN} -C /skywalking \
  && mv ${SKYWALKING_HOME}/apache-skywalking-apm-bin/agent /skywalking \
  && rm -rf ${SKYWALKING_HOME}/apache-skywalking-apm-bin \
  && rm -rf ${SKYWALKING_HOME}/${SKYWALKING_BIN}

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
