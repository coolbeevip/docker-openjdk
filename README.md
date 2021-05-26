# openjdk

# ENV

* JAVA_HEAP_SIZE_OPTS

-Xms256m -Xmx1g -Xss256k -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m

* JAVA_GC_OPTS

-XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:MaxTenuringThreshold=15 -XX:+ExplicitGCInvokesConcurrent -XX:+CMSParallelRemarkEnabled -XX:SurvivorRatio=8 -XX:+UseCompressedOops

* SW_AGENT_ENABLED

Skywalking Agent 8.1.0，默认不启用，可以启动时使用 -e SW_AGENT_ENABLED=true 启用


## System

* bash
* tzdata
* openssh
* su-exec
* unzip
* libzmq
* ttf-dejavu
* curl
* shadow
* glibc
* jattach

* 字符集

en_US.UTF-8

* 时区

Asia/Shanghai
