# 基础镜像

* Base Image openjdk:8-jre-alpine

* JAVA_OPTS

```
JAVA_OPTS="-Xms512m -Xmx1g -Xss256k -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:MaxTenuringThreshold=15 -XX:+ExplicitGCInvokesConcurrent -XX:+CMSParallelRemarkEnabled -XX:SurvivorRatio=8 -XX:+UseCompressedOops"
```

可以启动镜像时使用 -e JAVA_OPTS=xxx 覆盖

* Skywalking Agent 8.1.0

默认不启用，可以启动时使用 -e SW_AGENT_ENABLED=true 启用

* Linux Tools

bash tzdata openssh su-exec unzip libzmq ttf-dejavu curl shadow glibc jattach

* 字符集

en_US.UTF-8

* 时区

Asia/Shanghai
